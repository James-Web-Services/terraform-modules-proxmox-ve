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
| [proxmox_download_file.this](https://registry.terraform.io/providers/bpg/proxmox/0.111.1/docs/resources/download_file) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_checksum"></a> [checksum](#input\_checksum) | The checksum of the file. | `string` | `null` | no |
| <a name="input_checksum_algorithm"></a> [checksum\_algorithm](#input\_checksum\_algorithm) | The algorithm used for the checksum. | `string` | `null` | no |
| <a name="input_content_type"></a> [content\_type](#input\_content\_type) | The file content type. | `string` | n/a | yes |
| <a name="input_datastore_id"></a> [datastore\_id](#input\_datastore\_id) | The datastore ID on Proxmox. | `string` | `"local"` | no |
| <a name="input_decompression_algorithm"></a> [decompression\_algorithm](#input\_decompression\_algorithm) | The decompression algorithm for the file | `string` | `null` | no |
| <a name="input_file_name"></a> [file\_name](#input\_file\_name) | The file name of the file. If unset, will be inferred from the URL. | `string` | `null` | no |
| <a name="input_node_name"></a> [node\_name](#input\_node\_name) | The Proxmox node name. | `string` | n/a | yes |
| <a name="input_overwrite"></a> [overwrite](#input\_overwrite) | Whether to overwrite the file if changes are detected or if a new version is available. | `bool` | `false` | no |
| <a name="input_url"></a> [url](#input\_url) | The URL of the file to download. | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the downloaded file. |
<!-- END_TF_DOCS -->
