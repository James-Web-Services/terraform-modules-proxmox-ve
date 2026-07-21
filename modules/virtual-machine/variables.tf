################################################################
# Virtual Machine
################################################################
variable "node_name" {
  description = "The Proxmox node name."
  type        = string
}

variable "name" {
  description = "The name of the virtual machine."
  type        = string
}

variable "notes" {
  description = "The notes of the virtual machine."
  type        = string
  default     = null
}

variable "vm_id" {
  description = "The ID of the virtual machine. If unset, a random ID will be set instead."
  type        = number
  default     = null
}

variable "on_boot" {
  description = "Whether the virtual machine should be started on boot."
  type        = bool
  default     = true
}

variable "machine" {
  description = "The machine type."
  type        = string
  default     = "q35"
}

variable "bios" {
  description = "The BIOS type."
  type        = string
  default     = "ovmf"
}

variable "scsi_hardware" {
  description = "The SCSI hardware type."
  type        = string
  default     = "virtio-scsi-single"
}

variable "operating_system_type" {
  description = "The operating system type."
  type        = string
  default     = "l26"
}

variable "cpu_type" {
  description = "The CPU type."
  type        = string
  default     = "x86-64-v2-AES"
}

variable "cpu_cores" {
  description = "The number of CPU cores to assign."
  type        = number
}

variable "memory" {
  description = "The amount of memory to assign (in MiB)."
  type        = number
}

variable "memory_ballooning" {
  description = "Whether to enable memory ballooning."
  type        = bool
  default     = true
}

variable "boot_order" {
  description = "List of boot device to boot from in the order they appear."
  type        = list(string)
  default     = null
}

variable "datastore_id" {
  description = "The datastore ID for all disks. This includes the root disk, EFI disk, and any additional disks. If a datastore ID is specified for a specific resource, that datastore ID will be used instead."
  type        = string
  default     = "local-lvm"
}

variable "disk_datastore_id" {
  description = "The datastore ID for the virtual machine disk."
  type        = string
  default     = null
}

variable "disk_image_id" {
  description = "The ID of the image to use for the virtual machine disk."
  type        = string
  default     = null
}

variable "disk_size" {
  description = "The size of the root disk (in GiB)."
  type        = number
}

variable "disk_interface" {
  description = "The name of the root disk interface."
  type        = string
  default     = "scsi0"
}

variable "disk_iothread" {
  description = "Whether to enable iothread on the disk."
  type        = bool
  default     = true
}

variable "disk_discard" {
  description = "Whether to enable discard on the disk."
  type        = bool
  default     = true
}

variable "disk_cache" {
  description = "Cache type on the disk."
  type        = string
  default     = "none"
}

variable "disk_ssd" {
  description = "Whether to enable SSD emulation on the disk."
  type        = bool
  default     = false
}

variable "additional_disks" {
  description = "Map of additional disks to add to the virtual machine."

  type = map(object({
    size         = number
    interface    = string
    datastore_id = optional(string)
    iothread     = optional(bool, true)
    discard      = optional(bool, true)
    cache        = optional(string, "none")
    ssd          = optional(bool, false)
  }))

  default = {}
}

variable "cdrom_file_id" {
  description = "The ID of the ISO to use for the cdrom."
  type        = string
  default     = null
}

variable "cdrom_interface" {
  description = "The name of the default CD-ROM interface."
  type        = string
  default     = "ide3"
}

variable "rng_enabled" {
  description = "Whether the enable a RNG device."
  type        = bool
  default     = false
}

variable "rng_source" {
  description = "The RNG source."
  type        = string
  default     = "/dev/urandom"
}

variable "rng_max_bytes" {
  description = "The RNG max bytes."
  type        = number
  default     = 1024
}

variable "rng_period" {
  description = "The RNG period."
  type        = number
  default     = 1000
}

variable "efi_disk_datastore_id" {
  description = "The datastore ID for the EFI disk."
  type        = string
  default     = null
}

variable "efi_disk_type" {
  description = "The size of the EFI disk (in MiB)."
  type        = string
  default     = "4m"
}

variable "efi_disk_file_format" {
  description = "The file format of the EFI disk."
  type        = string
  default     = "raw"
}

variable "efi_disk_pre_enrolled_keys" {
  description = "Whether to use standard secure boot keys."
  type        = bool
  default     = true
}

variable "agent_enabled" {
  description = "Whether to enable the QEMU guest agent."
  type        = bool
  default     = true
}

# Terraform does not proide functions for checking if an IP is in a CIDR block.
# This is an inelegant solution to make sure we are pulling the correct IP
# from the list of IPs returned by the QEMU agent.
variable "ipv4_cidr_prefix" {
  description = "The prefix of the CIDR block used to match the IPv4 address."
  type        = string
  default     = "10.30"
}

variable "startup_order" {
  description = "The order value for the startup."
  type        = number
  default     = null

  validation {
    condition     = var.startup_order == null || var.startup_order >= 0
    error_message = "The value of startup_order must be non-negative."
  }
}

variable "startup_up_delay" {
  description = "The up delay value for the startup."
  type        = number
  default     = null

  validation {
    condition     = var.startup_up_delay == null || var.startup_up_delay >= 0
    error_message = "The value of startup_up_delay must be non-negative."
  }
}

variable "startup_down_delay" {
  description = "The down delay value for the startup."
  type        = number
  default     = null

  validation {
    condition     = var.startup_down_delay == null || var.startup_down_delay >= 0
    error_message = "The value of startup_down_delay must be non-negative."
  }
}

variable "network_model" {
  description = "The network model."
  type        = string
  default     = "virtio"
}

variable "network_firewall_enabled" {
  description = "Whether to enable the firewall on the network interface."
  type        = bool
  default     = true
}

variable "network_bridge" {
  description = "The network bridge."
  type        = string
}

variable "network_mac_address" {
  description = "The MAC address."
  type        = string
  default     = null
}

variable "dns_servers" {
  description = "List of DNS servers."
  type        = list(string)
  default     = null
}

variable "dns_domain" {
  description = "The DNS domain."
  type        = string
  default     = null
}

variable "ipv4_address" {
  description = "The IPv4 address."
  type        = string
  default     = "dhcp"
}

variable "ipv4_gateway" {
  description = "The IPv4 gateway."
  type        = string
  default     = null
}

variable "serial_device_enabled" {
  description = "Whether to create a serial device. Required for cloud-init to work."
  type        = bool
  default     = true
}

variable "snippets_datastore_id" {
  description = "The datastore ID for the snippets."
  type        = string
  default     = "local"
}

variable "cloud_init_datastore_id" {
  description = "The datastore ID for the cloud-init disk."
  type        = string
  default     = null
}

variable "custom_user_cloud_init_enabled" {
  description = "Whether to enable custom user cloud-init snippet file."
  type        = bool
  default     = true
}

variable "custom_user_cloud_init" {
  description = "Custom user cloud-init in HCL format to be merged with the defaults."
  type        = map(any)
  default     = {}
}

variable "ssh_authorized_keys" {
  description = "List of SSH public keys set by cloud-init."
  type        = list(string)
  default     = null
}

variable "password_hash" {
  description = "Hash of the password set by cloud-init."
  type        = string
  default     = null
  sensitive   = true
}

variable "host_pci" {
  description = "Host PCI to pass through to the virtual machine."

  type = map(object({
    device  = string
    id      = optional(string)
    mapping = optional(string)
    pcie    = optional(bool, false)
    rombar  = optional(bool, true)
    xvga    = optional(bool, false)
  }))

  default = {}
}

variable "tpm_enabled" {
  description = "Whether to create a TPM device."
  type        = bool
  default     = false
}

variable "tpm_datastore_id" {
  description = "The datastore ID for the virtual machine TPM."
  type        = string
  default     = null
}

variable "tpm_version" {
  description = "TPM version to use."
  type        = string
  default     = "v2.0"
}

variable "tags" {
  description = "List of tags."
  type        = list(string)
  default     = null
}

################################################################
# Firewall
################################################################

variable "firewall_enabled" {
  description = "Whether to enable the firewall."
  type        = bool
  default     = true
}
variable "firewall_dhcp" {
  description = "Whether to enable DHCP on the firewall."
  type        = bool
  default     = true
}

variable "firewall_ndp" {
  description = "Whether to enable NDP on the firewall."
  type        = bool
  default     = true
}

variable "firewall_router_advertisement" {
  description = "Whether to enable router advertisement on the firewall."
  type        = bool
  default     = false
}

variable "firewall_mac_filter" {
  description = "Whether to enable MAC filter on the firewall."
  type        = bool
  default     = true
}

variable "firewall_ip_filter" {
  description = "Whether to enable IP filter on the firewall."
  type        = bool
  default     = false
}

variable "firewall_input_policy" {
  description = "Firewall input policy."
  type        = string
  default     = "DROP"
}

variable "firewall_output_policy" {
  description = "Firewall output policy."
  type        = string
  default     = "ACCEPT"
}

variable "firewall_log_level_in" {
  description = "Firewall log level in."
  type        = string
  default     = "nolog"
}

variable "firewall_log_level_out" {
  description = "Firewall log level out."
  type        = string
  default     = "nolog"
}

variable "firewall_rules" {
  description = "List of firewall rules."

  type = list(object({
    comment        = string
    enabled        = optional(bool, true)
    iface          = optional(string, "net0")
    security_group = optional(string)
    proto          = optional(string)
    macro          = optional(string)
    type           = optional(string)
    action         = optional(string)
    source         = optional(string)
    sport          = optional(string)
    dest           = optional(string)
    dport          = optional(string)
    log            = optional(string)
  }))

  default = []
}

variable "firewall_aliases" {
  description = "List of firewall aliases at the virtual machine level."

  type = list(object({
    name    = string
    cidr    = string
    comment = string
  }))

  default = []
}

variable "firewall_ipsets" {
  description = "List of firewall IPsets at the virtual machine level."

  type = list(object({
    name    = string
    comment = string

    cidrs = optional(list(object({
      cidr    = string
      comment = string
      nomatch = optional(bool, false)
    })), [])
  }))

  default = []
}
