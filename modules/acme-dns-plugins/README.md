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
| [proxmox_acme_dns_plugin.this](https://registry.terraform.io/providers/bpg/proxmox/0.111.1/docs/resources/acme_dns_plugin) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_plugins"></a> [plugins](#input\_plugins) | List of DNS plugins. | <pre>list(object({<br/>    id               = string<br/>    api              = string<br/>    data             = optional(map(string))<br/>    data_wo          = optional(map(string))<br/>    data_wo_version  = optional(number)<br/>    digest           = optional(string)<br/>    enabled          = optional(bool, true)<br/>    validation_delay = optional(number, 30)<br/>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_plugin_ids"></a> [plugin\_ids](#output\_plugin\_ids) | IDs of the DNS plugins. |
<!-- END_TF_DOCS -->
