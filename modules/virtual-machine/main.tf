
################################################################
# Cloud-init
################################################################
resource "random_string" "cloud_init" {
  count = var.custom_user_cloud_init_enabled ? 1 : 0

  length  = 8
  upper   = false
  special = false
}

resource "proxmox_virtual_environment_file" "user_cloud_init" {
  count = var.custom_user_cloud_init_enabled ? 1 : 0

  datastore_id = var.snippets_datastore_id
  node_name    = var.node_name
  content_type = "snippets"

  source_raw {
    file_name = "${random_string.cloud_init[0].result}.user-cloud-init.yml"

    data = <<-EOF
#cloud-config
${yamlencode(merge(
    {
      hostname            = var.name
      fqdn                = var.name
      ssh_authorized_keys = var.ssh_authorized_keys
      password            = var.password_hash
      manage_etc_hosts    = true
      package_upgrade     = true

      chpasswd = {
        expire = false
      }

      users = [
        "default"
      ]

      packages = [
        "qemu-guest-agent"
      ]

      runcmd = [
        "systemctl start qemu-guest-agent"
      ]
    },
    var.custom_user_cloud_init
))}
    EOF
}
}

################################################################
# Virtual Machine
################################################################
resource "proxmox_virtual_environment_vm" "this" {
  node_name     = var.node_name
  name          = var.name
  description   = var.notes
  vm_id         = var.vm_id
  on_boot       = var.on_boot
  tags          = var.tags
  machine       = var.machine
  bios          = var.bios
  scsi_hardware = var.scsi_hardware

  boot_order = var.boot_order != null ? var.boot_order : concat(
    [var.disk_interface],
    var.file_id != null ? [var.cdrom_interface] : [], ["net0"]
  )

  agent {
    enabled = var.agent_enabled

    wait_for_ip {
      ipv4 = true
    }
  }

  dynamic "serial_device" {
    for_each = var.create_serial_device ? [1] : []

    content {}
  }

  cpu {
    cores = var.cpu_cores
    type  = var.cpu_type
  }

  memory {
    dedicated = var.memory
    floating  = var.ballooning_enabled ? var.memory : 0
  }

  network_device {
    bridge      = var.network_bridge
    mac_address = var.network_mac_address
    model       = var.network_model
    firewall    = var.network_firewall_enabled
  }

  dynamic "cdrom" {
    for_each = var.file_id != null ? [1] : []

    content {
      file_id   = var.file_id
      interface = var.cdrom_interface
    }
  }

  disk {
    datastore_id = coalesce(var.disk_datastore_id, var.datastore_id)
    size         = var.disk_size
    import_from  = var.image_id
    interface    = var.disk_interface
    iothread     = var.disk_iothread_enabled
    discard      = var.disk_discard_enabled ? "on" : "ignore"
    cache        = var.disk_cache
    ssd          = var.disk_ssd
  }

  dynamic "disk" {
    for_each = var.additional_disks

    content {
      datastore_id = coalesce(disk.value.datastore_id, var.datastore_id)
      size         = disk.value.size
      interface    = disk.value.interface
      iothread     = disk.value.iothread
      discard      = disk.value.discard ? "on" : "ignore"
      cache        = disk.value.cache
      ssd          = disk.value.ssd
    }
  }

  dynamic "efi_disk" {
    for_each = var.bios == "ovmf" ? [1] : []

    content {
      datastore_id      = coalesce(var.efi_disk_datastore_id, var.datastore_id)
      file_format       = var.efi_disk_file_format
      type              = var.efi_disk_type
      pre_enrolled_keys = var.efi_disk_pre_enrolled_keys
    }
  }

  dynamic "rng" {
    for_each = var.rng_enabled ? [1] : []

    content {
      source    = var.rng_source
      max_bytes = var.rng_max_bytes
      period    = var.rng_period
    }
  }

  dynamic "hostpci" {
    for_each = var.host_pci

    content {
      device  = hostpci.value.device
      id      = hostpci.value.id
      mapping = hostpci.value.mapping
      pcie    = hostpci.value.pcie
      rombar  = hostpci.value.rombar
      xvga    = hostpci.value.xvga
    }
  }

  dynamic "tpm_state" {
    for_each = var.tpm_enabled ? [1] : []

    content {
      datastore_id = coalesce(var.tpm_datastore_id, var.datastore_id)
      version      = var.tpm_version
    }
  }

  dynamic "startup" {
    # Using a dynamic block here to work around a bug where the provider will always show
    # a difference in state if we create the startup block with null values.
    for_each = var.startup_order != null || var.startup_up_delay != null || var.startup_down_delay != null ? [1] : []

    content {
      order      = var.startup_order
      up_delay   = var.startup_up_delay
      down_delay = var.startup_down_delay
    }
  }

  operating_system {
    type = var.operating_system
  }

  initialization {
    datastore_id      = coalesce(var.cloud_init_datastore_id, var.datastore_id)
    user_data_file_id = try(proxmox_virtual_environment_file.user_cloud_init[0].id, null)

    ip_config {
      ipv4 {
        address = var.ipv4_address
        gateway = var.ipv4_gateway
      }
    }

    dynamic "dns" {
      # Using a dynamic block here to work around a bug where the provider will always show
      # a difference in state if we have null values for the DNS configuration.
      for_each = var.dns_servers != null || var.dns_domain != null ? [1] : []

      content {
        servers = var.dns_servers
        domain  = var.dns_domain
      }
    }
  }

  lifecycle {
    ignore_changes = [
      disk[0].file_id,

      # When the user cloud-init content changes, the snippet will be re-created.
      # This triggers a force recreation of the VM, which we do not want.
      initialization[0].user_data_file_id,
    ]
  }
}

################################################################
# Firewall
################################################################
resource "proxmox_virtual_environment_firewall_options" "this" {
  node_name = proxmox_virtual_environment_vm.this.node_name
  vm_id     = proxmox_virtual_environment_vm.this.id

  enabled       = var.firewall_enabled
  dhcp          = var.firewall_dhcp_enabled
  ndp           = var.firewall_ndp_enabled
  radv          = var.firewall_router_advertisement_enabled
  macfilter     = var.firewall_mac_filter_enabled
  ipfilter      = var.firewall_ip_filter_enabled
  log_level_in  = var.firewall_log_level_in
  log_level_out = var.firewall_log_level_out
  input_policy  = var.firewall_input_policy
  output_policy = var.firewall_output_policy
}

resource "proxmox_virtual_environment_firewall_alias" "this" {
  for_each = { for v in var.firewall_aliases : v.name => v }

  node_name = proxmox_virtual_environment_vm.this.node_name
  vm_id     = proxmox_virtual_environment_vm.this.id

  name    = each.value.name
  cidr    = each.value.cidr
  comment = each.value.comment
}

resource "proxmox_virtual_environment_firewall_ipset" "this" {
  depends_on = [
    proxmox_virtual_environment_firewall_alias.this
  ]

  for_each = { for v in var.firewall_ipsets : v.name => v }

  node_name = proxmox_virtual_environment_vm.this.node_name
  vm_id     = proxmox_virtual_environment_vm.this.id

  name    = each.value.name
  comment = each.value.comment

  dynamic "cidr" {
    for_each = each.value.cidrs

    content {
      name    = cidr.value.cidr
      comment = cidr.value.comment
      nomatch = cidr.value.nomatch
    }
  }
}

resource "proxmox_virtual_environment_firewall_rules" "this" {
  depends_on = [
    proxmox_virtual_environment_firewall_alias.this,
    proxmox_virtual_environment_firewall_ipset.this
  ]

  node_name = proxmox_virtual_environment_vm.this.node_name
  vm_id     = proxmox_virtual_environment_vm.this.id

  dynamic "rule" {
    for_each = var.firewall_rules

    content {
      comment        = rule.value.comment
      enabled        = rule.value.enabled
      iface          = rule.value.iface
      security_group = rule.value.security_group
      proto          = rule.value.proto
      macro          = rule.value.macro
      type           = rule.value.type
      action         = rule.value.action
      source         = rule.value.source
      sport          = rule.value.sport
      dest           = rule.value.dest
      dport          = rule.value.dport
      log            = rule.value.log
    }
  }
}
