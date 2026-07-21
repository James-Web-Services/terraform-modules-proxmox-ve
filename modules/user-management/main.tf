################################################################
# Groups
################################################################

resource "proxmox_virtual_environment_group" "this" {
  for_each = { for group in var.groups : group.name => group }

  group_id = each.value.name
  comment  = each.value.comment

  dynamic "acl" {
    for_each = each.value.acls

    content {
      path      = acl.value.path
      propagate = acl.value.propagate
      role_id   = acl.value.role_id
    }
  }
}

################################################################
# Users
################################################################

resource "random_password" "user" {
  for_each = { for user in var.users : user.username => user if user.password == null }

  length           = 24
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "proxmox_virtual_environment_user" "this" {
  for_each = { for user in var.users : user.username => user }

  user_id         = each.value.username
  comment         = each.value.comment
  password        = each.value.password == null ? random_password.user[each.key].result : each.value.password
  first_name      = each.value.first_name
  last_name       = each.value.last_name
  email           = each.value.email
  expiration_date = each.value.expiration_date
  enabled         = each.value.enabled
  keys            = each.value.keys
  groups          = each.value.groups

  dynamic "acl" {
    for_each = each.value.acls

    content {
      path      = acl.value.path
      propagate = acl.value.propagate
      role_id   = acl.value.role_id
    }
  }
}

################################################################
# User Tokens
################################################################

locals {
  user_tokens = flatten([
    for user in var.users : [
      for token in user.tokens : {
        user  = user
        token = token
      }
    ]
  ])
}

resource "proxmox_user_token" "this" {
  for_each = { for user_token in local.user_tokens : "${user_token.user.username}/${user_token.token.name}" => user_token }

  user_id               = each.value.user.username
  token_name            = each.value.token.name
  comment               = each.value.token.comment
  expiration_date       = each.value.token.expiration_date
  privileges_separation = each.value.token.privileges_separation
}
