<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | 0.111.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) | 0.111.0 |
| <a name="provider_random"></a> [random](#provider\_random) | ~> 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [proxmox_virtual_environment_file.user_cloud_init](https://registry.terraform.io/providers/bpg/proxmox/0.111.0/docs/resources/virtual_environment_file) | resource |
| [proxmox_virtual_environment_firewall_alias.this](https://registry.terraform.io/providers/bpg/proxmox/0.111.0/docs/resources/virtual_environment_firewall_alias) | resource |
| [proxmox_virtual_environment_firewall_ipset.this](https://registry.terraform.io/providers/bpg/proxmox/0.111.0/docs/resources/virtual_environment_firewall_ipset) | resource |
| [proxmox_virtual_environment_firewall_options.this](https://registry.terraform.io/providers/bpg/proxmox/0.111.0/docs/resources/virtual_environment_firewall_options) | resource |
| [proxmox_virtual_environment_firewall_rules.this](https://registry.terraform.io/providers/bpg/proxmox/0.111.0/docs/resources/virtual_environment_firewall_rules) | resource |
| [proxmox_virtual_environment_vm.this](https://registry.terraform.io/providers/bpg/proxmox/0.111.0/docs/resources/virtual_environment_vm) | resource |
| [random_string.cloud_init](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_additional_disks"></a> [additional\_disks](#input\_additional\_disks) | Map of additional disks to add to the virtual machine. | <pre>map(object({<br/>    size         = number<br/>    interface    = string<br/>    datastore_id = optional(string)<br/>    iothread     = optional(bool, true)<br/>    discard      = optional(bool, true)<br/>    cache        = optional(string, "none")<br/>    ssd          = optional(bool, false)<br/>  }))</pre> | `{}` | no |
| <a name="input_agent_enabled"></a> [agent\_enabled](#input\_agent\_enabled) | Whether to enable the QEMU guest agent. | `bool` | `true` | no |
| <a name="input_ballooning_enabled"></a> [ballooning\_enabled](#input\_ballooning\_enabled) | Whether to enable ballooning. | `bool` | `true` | no |
| <a name="input_bios"></a> [bios](#input\_bios) | The BIOS type. | `string` | `"seabios"` | no |
| <a name="input_boot_order"></a> [boot\_order](#input\_boot\_order) | List of boot device to boot from in the order they appear. | `list(string)` | `null` | no |
| <a name="input_cdrom_interface"></a> [cdrom\_interface](#input\_cdrom\_interface) | The name of the default CD-ROM interface. | `string` | `"ide3"` | no |
| <a name="input_cloud_init_datastore_id"></a> [cloud\_init\_datastore\_id](#input\_cloud\_init\_datastore\_id) | The datastore ID for the cloud-init disk. | `string` | `null` | no |
| <a name="input_cpu_cores"></a> [cpu\_cores](#input\_cpu\_cores) | The number of CPU cores to assign. | `number` | n/a | yes |
| <a name="input_cpu_type"></a> [cpu\_type](#input\_cpu\_type) | The CPU type. | `string` | `"x86-64-v2-AES"` | no |
| <a name="input_create_serial_device"></a> [create\_serial\_device](#input\_create\_serial\_device) | Whether to create a serial device. Required for cloud-init to work. | `bool` | `true` | no |
| <a name="input_custom_user_cloud_init"></a> [custom\_user\_cloud\_init](#input\_custom\_user\_cloud\_init) | Custom user cloud-init in HCL format to be merged with the defaults. | `any` | `{}` | no |
| <a name="input_custom_user_cloud_init_enabled"></a> [custom\_user\_cloud\_init\_enabled](#input\_custom\_user\_cloud\_init\_enabled) | Whether to enable custom user cloud-init snippet file. | `bool` | `true` | no |
| <a name="input_datastore_id"></a> [datastore\_id](#input\_datastore\_id) | The datastore ID for all disks. This includes the root disk, EFI disk, and any additional disks. If a datastore ID is specified for a specific resource, that datastore ID will be used instead. | `string` | `"local-lvm"` | no |
| <a name="input_disk_cache"></a> [disk\_cache](#input\_disk\_cache) | Cache type on the disk. | `string` | `"none"` | no |
| <a name="input_disk_datastore_id"></a> [disk\_datastore\_id](#input\_disk\_datastore\_id) | The datastore ID for the virtual machine disk. | `string` | `null` | no |
| <a name="input_disk_discard_enabled"></a> [disk\_discard\_enabled](#input\_disk\_discard\_enabled) | Whether to enable disard on the disk. | `bool` | `true` | no |
| <a name="input_disk_interface"></a> [disk\_interface](#input\_disk\_interface) | The name of the root disk interface. | `string` | `"scsi0"` | no |
| <a name="input_disk_iothread_enabled"></a> [disk\_iothread\_enabled](#input\_disk\_iothread\_enabled) | Whether to enable iothread on the disk. | `bool` | `true` | no |
| <a name="input_disk_size"></a> [disk\_size](#input\_disk\_size) | The size of the root disk (in GiB). | `number` | n/a | yes |
| <a name="input_disk_ssd"></a> [disk\_ssd](#input\_disk\_ssd) | Whether to enable SSD emulation on the disk. | `bool` | `false` | no |
| <a name="input_dns_domain"></a> [dns\_domain](#input\_dns\_domain) | The DNS domain. | `string` | `null` | no |
| <a name="input_dns_servers"></a> [dns\_servers](#input\_dns\_servers) | List of DNS servers. | `list(string)` | `null` | no |
| <a name="input_efi_disk_datastore_id"></a> [efi\_disk\_datastore\_id](#input\_efi\_disk\_datastore\_id) | The datastore ID for the EFI disk. | `string` | `null` | no |
| <a name="input_efi_disk_file_format"></a> [efi\_disk\_file\_format](#input\_efi\_disk\_file\_format) | The file format of the EFI disk. | `string` | `"raw"` | no |
| <a name="input_efi_disk_pre_enrolled_keys"></a> [efi\_disk\_pre\_enrolled\_keys](#input\_efi\_disk\_pre\_enrolled\_keys) | Whether to use standard secure boot keys. | `bool` | `true` | no |
| <a name="input_efi_disk_type"></a> [efi\_disk\_type](#input\_efi\_disk\_type) | The size of the EFI disk (in MiB). | `string` | `"4m"` | no |
| <a name="input_file_id"></a> [file\_id](#input\_file\_id) | The ID of the ISO to use. | `string` | `null` | no |
| <a name="input_firewall_aliases"></a> [firewall\_aliases](#input\_firewall\_aliases) | List of firewall aliases at the virtual machine level. | <pre>list(object({<br/>    name    = string<br/>    cidr    = string<br/>    comment = string<br/>  }))</pre> | `[]` | no |
| <a name="input_firewall_dhcp_enabled"></a> [firewall\_dhcp\_enabled](#input\_firewall\_dhcp\_enabled) | Whether to enable DHCP on the firewall. | `bool` | `true` | no |
| <a name="input_firewall_enabled"></a> [firewall\_enabled](#input\_firewall\_enabled) | Whether to enable the firewall. | `bool` | `true` | no |
| <a name="input_firewall_input_policy"></a> [firewall\_input\_policy](#input\_firewall\_input\_policy) | Firewall input policy. | `string` | `"DROP"` | no |
| <a name="input_firewall_ip_filter_enabled"></a> [firewall\_ip\_filter\_enabled](#input\_firewall\_ip\_filter\_enabled) | Whether to enable IP filter on the firewall. | `bool` | `false` | no |
| <a name="input_firewall_ipsets"></a> [firewall\_ipsets](#input\_firewall\_ipsets) | List of firewall IPsets at the virtual machine level. | <pre>list(object({<br/>    name    = string<br/>    comment = string<br/><br/>    cidrs = optional(list(object({<br/>      cidr    = string<br/>      comment = string<br/>      nomatch = optional(bool, false)<br/>    })), [])<br/>  }))</pre> | `[]` | no |
| <a name="input_firewall_log_level_in"></a> [firewall\_log\_level\_in](#input\_firewall\_log\_level\_in) | Firewall log level in. | `string` | `"nolog"` | no |
| <a name="input_firewall_log_level_out"></a> [firewall\_log\_level\_out](#input\_firewall\_log\_level\_out) | Firewall log level out. | `string` | `"nolog"` | no |
| <a name="input_firewall_mac_filter_enabled"></a> [firewall\_mac\_filter\_enabled](#input\_firewall\_mac\_filter\_enabled) | Whether to enable MAC filter on the firewall. | `bool` | `true` | no |
| <a name="input_firewall_ndp_enabled"></a> [firewall\_ndp\_enabled](#input\_firewall\_ndp\_enabled) | Whether to enable NDP on the firewall. | `bool` | `true` | no |
| <a name="input_firewall_output_policy"></a> [firewall\_output\_policy](#input\_firewall\_output\_policy) | Firewall output policy. | `string` | `"ACCEPT"` | no |
| <a name="input_firewall_router_advertisement_enabled"></a> [firewall\_router\_advertisement\_enabled](#input\_firewall\_router\_advertisement\_enabled) | Whether to enable router advertisement on the firewall. | `bool` | `false` | no |
| <a name="input_firewall_rules"></a> [firewall\_rules](#input\_firewall\_rules) | List of firewall rules. | <pre>list(object({<br/>    comment        = string<br/>    enabled        = optional(bool, true)<br/>    iface          = optional(string, "net0")<br/>    security_group = optional(string)<br/>    proto          = optional(string)<br/>    macro          = optional(string)<br/>    type           = optional(string)<br/>    action         = optional(string)<br/>    source         = optional(string)<br/>    sport          = optional(string)<br/>    dest           = optional(string)<br/>    dport          = optional(string)<br/>    log            = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_host_pci"></a> [host\_pci](#input\_host\_pci) | Host PCI to pass through to the virtual machine. | <pre>map(object({<br/>    device  = string<br/>    id      = optional(string)<br/>    mapping = optional(string)<br/>    pcie    = optional(bool, false)<br/>    rombar  = optional(bool, true)<br/>    xvga    = optional(bool, false)<br/>  }))</pre> | `{}` | no |
| <a name="input_image_id"></a> [image\_id](#input\_image\_id) | The ID of the image to use for the virtual machine. | `string` | `null` | no |
| <a name="input_ipv4_address"></a> [ipv4\_address](#input\_ipv4\_address) | The IPv4 address. | `string` | `"dhcp"` | no |
| <a name="input_ipv4_gateway"></a> [ipv4\_gateway](#input\_ipv4\_gateway) | The IPv4 gateway. | `string` | `null` | no |
| <a name="input_machine"></a> [machine](#input\_machine) | The machine type. | `string` | `"q35"` | no |
| <a name="input_memory"></a> [memory](#input\_memory) | The amount of memory to assign (in MiB). | `number` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the virtual machine. | `string` | n/a | yes |
| <a name="input_network_bridge"></a> [network\_bridge](#input\_network\_bridge) | The network bridge. | `string` | n/a | yes |
| <a name="input_network_firewall_enabled"></a> [network\_firewall\_enabled](#input\_network\_firewall\_enabled) | Whether to enable the firewall on the network interface. | `bool` | `true` | no |
| <a name="input_network_mac_address"></a> [network\_mac\_address](#input\_network\_mac\_address) | The MAC address. | `string` | `null` | no |
| <a name="input_network_model"></a> [network\_model](#input\_network\_model) | The network model. | `string` | `"virtio"` | no |
| <a name="input_node_name"></a> [node\_name](#input\_node\_name) | The Proxmox node name. | `string` | n/a | yes |
| <a name="input_notes"></a> [notes](#input\_notes) | The notes of the virtual machine. | `string` | `null` | no |
| <a name="input_on_boot"></a> [on\_boot](#input\_on\_boot) | Whether the virtual machine should be started on boot. | `bool` | `true` | no |
| <a name="input_operating_system"></a> [operating\_system](#input\_operating\_system) | The operating system type. | `string` | `"l26"` | no |
| <a name="input_password_hash"></a> [password\_hash](#input\_password\_hash) | Hash of the password set by cloud-init. | `string` | `null` | no |
| <a name="input_rng_enabled"></a> [rng\_enabled](#input\_rng\_enabled) | Whether the enable a RNG device. | `bool` | `false` | no |
| <a name="input_rng_max_bytes"></a> [rng\_max\_bytes](#input\_rng\_max\_bytes) | The RNG max bytes. | `number` | `1024` | no |
| <a name="input_rng_period"></a> [rng\_period](#input\_rng\_period) | The RNG period. | `number` | `1000` | no |
| <a name="input_rng_source"></a> [rng\_source](#input\_rng\_source) | The RNG source. | `string` | `"/dev/urandom"` | no |
| <a name="input_scsi_hardware"></a> [scsi\_hardware](#input\_scsi\_hardware) | The SCIS hardware type. | `string` | `"virtio-scsi-single"` | no |
| <a name="input_snippets_datastore_id"></a> [snippets\_datastore\_id](#input\_snippets\_datastore\_id) | The datastore ID for the snippets. | `string` | `"local"` | no |
| <a name="input_ssh_authorized_keys"></a> [ssh\_authorized\_keys](#input\_ssh\_authorized\_keys) | List of SSH public keys. | `list(string)` | `null` | no |
| <a name="input_startup_down_delay"></a> [startup\_down\_delay](#input\_startup\_down\_delay) | The down delay value for the startup. | `number` | `null` | no |
| <a name="input_startup_order"></a> [startup\_order](#input\_startup\_order) | The order value for the startup. | `number` | `null` | no |
| <a name="input_startup_up_delay"></a> [startup\_up\_delay](#input\_startup\_up\_delay) | The up delay value for the startup. | `number` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | List of tags. | `list(string)` | `null` | no |
| <a name="input_tpm_datastore_id"></a> [tpm\_datastore\_id](#input\_tpm\_datastore\_id) | The datastore ID for the virtual machine TPM. | `string` | `null` | no |
| <a name="input_tpm_enabled"></a> [tpm\_enabled](#input\_tpm\_enabled) | Whether to create a TPM device. | `bool` | `false` | no |
| <a name="input_tpm_version"></a> [tpm\_version](#input\_tpm\_version) | TPM version to use. | `string` | `"v2.0"` | no |
| <a name="input_vm_id"></a> [vm\_id](#input\_vm\_id) | The ID of the virtual machine. If unset, a random ID will be set instead. | `number` | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID. |
| <a name="output_ipv4_address"></a> [ipv4\_address](#output\_ipv4\_address) | The IPv4 address. |
| <a name="output_mac_address"></a> [mac\_address](#output\_mac\_address) | The MAC address. |
| <a name="output_name"></a> [name](#output\_name) | The name. |
| <a name="output_node_name"></a> [node\_name](#output\_node\_name) | The node name. |
| <a name="output_user_cloud_init_snippet_file_name"></a> [user\_cloud\_init\_snippet\_file\_name](#output\_user\_cloud\_init\_snippet\_file\_name) | The file name of the user cloud-init snippet. |
<!-- END_TF_DOCS -->
