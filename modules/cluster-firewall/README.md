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
| [proxmox_virtual_environment_cluster_firewall.this](https://registry.terraform.io/providers/bpg/proxmox/0.111.1/docs/resources/virtual_environment_cluster_firewall) | resource |
| [proxmox_virtual_environment_cluster_firewall_security_group.this](https://registry.terraform.io/providers/bpg/proxmox/0.111.1/docs/resources/virtual_environment_cluster_firewall_security_group) | resource |
| [proxmox_virtual_environment_firewall_alias.this](https://registry.terraform.io/providers/bpg/proxmox/0.111.1/docs/resources/virtual_environment_firewall_alias) | resource |
| [proxmox_virtual_environment_firewall_ipset.this](https://registry.terraform.io/providers/bpg/proxmox/0.111.1/docs/resources/virtual_environment_firewall_ipset) | resource |
| [proxmox_virtual_environment_firewall_rules.this](https://registry.terraform.io/providers/bpg/proxmox/0.111.1/docs/resources/virtual_environment_firewall_rules) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_firewall_aliases"></a> [firewall\_aliases](#input\_firewall\_aliases) | List of firewall aliases. | <pre>list(object({<br/>    name    = string<br/>    cidr    = string<br/>    comment = string<br/>  }))</pre> | `[]` | no |
| <a name="input_firewall_ebtables_enabled"></a> [firewall\_ebtables\_enabled](#input\_firewall\_ebtables\_enabled) | Whether to enable ebtables. | `bool` | `true` | no |
| <a name="input_firewall_enabled"></a> [firewall\_enabled](#input\_firewall\_enabled) | Whether to enable the cluster firewall. | `bool` | `false` | no |
| <a name="input_firewall_forward_policy"></a> [firewall\_forward\_policy](#input\_firewall\_forward\_policy) | Firewall forward policy. | `string` | `"ACCEPT"` | no |
| <a name="input_firewall_input_policy"></a> [firewall\_input\_policy](#input\_firewall\_input\_policy) | Firewall input policy. | `string` | `"DROP"` | no |
| <a name="input_firewall_ipsets"></a> [firewall\_ipsets](#input\_firewall\_ipsets) | List of firewall IPsets. | <pre>list(object({<br/>    name    = string<br/>    comment = string<br/><br/>    cidrs = optional(list(object({<br/>      cidr    = string<br/>      comment = string<br/>      nomatch = optional(bool, false)<br/>    })), [])<br/>  }))</pre> | `[]` | no |
| <a name="input_firewall_log_ratelimit_burst"></a> [firewall\_log\_ratelimit\_burst](#input\_firewall\_log\_ratelimit\_burst) | The log ratelimit burst. | `number` | `5` | no |
| <a name="input_firewall_log_ratelimit_enabled"></a> [firewall\_log\_ratelimit\_enabled](#input\_firewall\_log\_ratelimit\_enabled) | Whether to enable the log ratelimit. | `bool` | `true` | no |
| <a name="input_firewall_log_ratelimit_rate"></a> [firewall\_log\_ratelimit\_rate](#input\_firewall\_log\_ratelimit\_rate) | The log ratelimit rate. | `string` | `"1/second"` | no |
| <a name="input_firewall_output_policy"></a> [firewall\_output\_policy](#input\_firewall\_output\_policy) | Firewall output policy. | `string` | `"ACCEPT"` | no |
| <a name="input_firewall_rules"></a> [firewall\_rules](#input\_firewall\_rules) | List of firewall rules. | <pre>list(object({<br/>    comment        = string<br/>    enabled        = optional(bool, true)<br/>    iface          = optional(string, "net0")<br/>    security_group = optional(string)<br/>    proto          = optional(string)<br/>    macro          = optional(string)<br/>    type           = optional(string)<br/>    action         = optional(string)<br/>    source         = optional(string)<br/>    sport          = optional(string)<br/>    dest           = optional(string)<br/>    dport          = optional(string)<br/>    log            = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_firewall_security_groups"></a> [firewall\_security\_groups](#input\_firewall\_security\_groups) | List of firewall security groups. | <pre>list(object({<br/>    name    = string<br/>    comment = string<br/><br/>    rules = optional(list(object({<br/>      action  = string<br/>      type    = string<br/>      comment = string<br/>      enabled = optional(bool, true)<br/>      source  = optional(string)<br/>      sport   = optional(string)<br/>      dest    = optional(string)<br/>      dport   = optional(string)<br/>      iface   = optional(string)<br/>      log     = optional(string)<br/>      macro   = optional(string)<br/>      proto   = optional(string)<br/>    })), [])<br/>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_firewall_alias_references"></a> [firewall\_alias\_references](#output\_firewall\_alias\_references) | Firewall alias references for use in other rules. |
| <a name="output_firewall_ipset_references"></a> [firewall\_ipset\_references](#output\_firewall\_ipset\_references) | Firewall IPset references for use in other rules. |
| <a name="output_firewall_security_group_references"></a> [firewall\_security\_group\_references](#output\_firewall\_security\_group\_references) | Firewall security group references for use in other rules. |
<!-- END_TF_DOCS -->
