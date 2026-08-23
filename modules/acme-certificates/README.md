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
| [proxmox_acme_certificate.this](https://registry.terraform.io/providers/bpg/proxmox/0.111.1/docs/resources/acme_certificate) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_certificates"></a> [certificates](#input\_certificates) | Map of certificates to create. | <pre>map(object({<br/>    account = string<br/>    force   = optional(bool, false)<br/><br/>    domains = list(object({<br/>      domain = string<br/>      alias  = optional(string)<br/>      plugin = optional(string)<br/>    }))<br/>  }))</pre> | `{}` | no |
| <a name="input_node_name"></a> [node\_name](#input\_node\_name) | The Proxmox node name. | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_ids"></a> [ids](#output\_ids) | IDs of the ACME certificates. |
<!-- END_TF_DOCS -->
