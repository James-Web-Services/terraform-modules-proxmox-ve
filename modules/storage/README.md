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
| [proxmox_storage_directory.this](https://registry.terraform.io/providers/bpg/proxmox/0.111.1/docs/resources/storage_directory) | resource |
| [proxmox_storage_lvmthin.this](https://registry.terraform.io/providers/bpg/proxmox/0.111.1/docs/resources/storage_lvmthin) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_directory"></a> [directory](#input\_directory) | List of directory storage to create. | <pre>list(object({<br/>    id               = string<br/>    path             = string<br/>    content          = optional(list(string))<br/>    create_base_path = optional(bool)<br/>    create_subdirs   = optional(bool)<br/>    nodes            = optional(list(string))<br/>    preallocation    = optional(string)<br/>    shared           = optional(bool)<br/>    enabled          = optional(bool, true)<br/>  }))</pre> | `[]` | no |
| <a name="input_lvm_thin"></a> [lvm\_thin](#input\_lvm\_thin) | List of LVM-thin storage to create. | <pre>list(object({<br/>    id           = string<br/>    thin_pool    = string<br/>    volume_group = string<br/>    content      = optional(list(string))<br/>    nodes        = optional(list(string))<br/>    enabled      = optional(bool, true)<br/>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_directory_ids"></a> [directory\_ids](#output\_directory\_ids) | IDs of the directory storage. |
| <a name="output_lvm_thin_ids"></a> [lvm\_thin\_ids](#output\_lvm\_thin\_ids) | IDs of the LVM thin storage. |
<!-- END_TF_DOCS -->
