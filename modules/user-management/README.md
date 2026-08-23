<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | 0.111.1 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) | 0.111.1 |
| <a name="provider_random"></a> [random](#provider\_random) | ~> 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [proxmox_acl.group](https://registry.terraform.io/providers/bpg/proxmox/0.111.1/docs/resources/acl) | resource |
| [proxmox_acl.user](https://registry.terraform.io/providers/bpg/proxmox/0.111.1/docs/resources/acl) | resource |
| [proxmox_acl.user_token](https://registry.terraform.io/providers/bpg/proxmox/0.111.1/docs/resources/acl) | resource |
| [proxmox_user_token.this](https://registry.terraform.io/providers/bpg/proxmox/0.111.1/docs/resources/user_token) | resource |
| [proxmox_virtual_environment_group.this](https://registry.terraform.io/providers/bpg/proxmox/0.111.1/docs/resources/virtual_environment_group) | resource |
| [proxmox_virtual_environment_user.this](https://registry.terraform.io/providers/bpg/proxmox/0.111.1/docs/resources/virtual_environment_user) | resource |
| [random_password.user](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_groups"></a> [groups](#input\_groups) | List of groups to create. | <pre>list(object({<br/>    name    = string<br/>    comment = string<br/><br/>    acls = optional(list(object({<br/>      path      = string<br/>      role_id   = string<br/>      propagate = optional(bool, true)<br/>    })), [])<br/>  }))</pre> | `[]` | no |
| <a name="input_users"></a> [users](#input\_users) | List of users to create. | <pre>list(object({<br/>    username        = string<br/>    comment         = string<br/>    password        = optional(string)<br/>    first_name      = optional(string)<br/>    last_name       = optional(string)<br/>    email           = optional(string)<br/>    expiration_date = optional(string)<br/>    keys            = optional(string)<br/>    enabled         = optional(bool, true)<br/>    groups          = optional(list(string), [])<br/><br/>    acls = optional(list(object({<br/>      path      = string<br/>      role_id   = string<br/>      propagate = optional(bool, true)<br/>    })), [])<br/><br/>    tokens = optional(list(object({<br/>      name                  = string<br/>      comment               = string<br/>      expiration_date       = optional(string)<br/>      privileges_separation = optional(bool, false)<br/><br/>      acls = optional(list(object({<br/>        path      = string<br/>        role_id   = string<br/>        propagate = optional(bool, true)<br/>      })), [])<br/>    })), [])<br/>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_user_passwords"></a> [user\_passwords](#output\_user\_passwords) | User passwords. |
| <a name="output_user_tokens"></a> [user\_tokens](#output\_user\_tokens) | User tokens. |
<!-- END_TF_DOCS -->
