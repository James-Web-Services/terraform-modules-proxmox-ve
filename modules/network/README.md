<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | 0.111.1 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) | 0.111.1 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [proxmox_network_linux_bond.this](https://registry.terraform.io/providers/bpg/proxmox/0.111.1/docs/resources/network_linux_bond) | resource |
| [proxmox_network_linux_bridge.this](https://registry.terraform.io/providers/bpg/proxmox/0.111.1/docs/resources/network_linux_bridge) | resource |
| [proxmox_network_linux_vlan.this](https://registry.terraform.io/providers/bpg/proxmox/0.111.1/docs/resources/network_linux_vlan) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_bonds"></a> [bonds](#input\_bonds) | List of bonds to create. | <pre>list(object({<br/>    name                  = string<br/>    slaves                = list(string)<br/>    comment               = string<br/>    address               = optional(string)<br/>    address6              = optional(string)<br/>    autostart             = optional(bool)<br/>    bond_mode             = optional(string)<br/>    bond_primary          = optional(string)<br/>    bond_xmit_hash_policy = optional(string)<br/>    gateway               = optional(string)<br/>    gateway6              = optional(string)<br/>    mtu                   = optional(number)<br/>    timeout_reload        = optional(number)<br/>  }))</pre> | `[]` | no |
| <a name="input_bridges"></a> [bridges](#input\_bridges) | List of bridges to create. | <pre>list(object({<br/>    name           = string<br/>    comment        = string<br/>    address        = optional(string)<br/>    address6       = optional(string)<br/>    autostart      = optional(bool)<br/>    gateway        = optional(string)<br/>    gateway6       = optional(string)<br/>    mtu            = optional(number)<br/>    ports          = optional(list(string))<br/>    timeout_reload = optional(number)<br/>    vids           = optional(string)<br/>    vlan_aware     = optional(bool)<br/>  }))</pre> | `[]` | no |
| <a name="input_node_name"></a> [node\_name](#input\_node\_name) | The Proxmox node name. | `string` | n/a | yes |
| <a name="input_vlans"></a> [vlans](#input\_vlans) | List of VLANs to create. | <pre>list(object({<br/>    name           = string<br/>    comment        = string<br/>    address        = optional(string)<br/>    address6       = optional(string)<br/>    autostart      = optional(bool)<br/>    gateway        = optional(string)<br/>    gateway6       = optional(string)<br/>    interface      = optional(string)<br/>    mtu            = optional(number)<br/>    timeout_reload = optional(number)<br/>    vlan           = optional(number)<br/>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_bonds"></a> [bonds](#output\_bonds) | Bonds created. |
| <a name="output_bridges"></a> [bridges](#output\_bridges) | Bridges created. |
| <a name="output_vlans"></a> [vlans](#output\_vlans) | VLANs created. |
<!-- END_TF_DOCS -->
