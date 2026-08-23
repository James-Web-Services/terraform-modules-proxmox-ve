################################################################
# Groups
################################################################
locals {
  group_acls = { for item in flatten([
    for group in var.groups : [
      for acl in group.acls : {
        group = group
        acl   = acl
      }
    ]
  ]) : "${item.group.name}/${item.acl.path}/${item.acl.role_id}" => item }
}

resource "proxmox_virtual_environment_group" "this" {
  for_each = { for group in var.groups : group.name => group }

  group_id = each.value.name
  comment  = each.value.comment
}

resource "proxmox_acl" "group" {
  for_each = local.group_acls

  group_id  = proxmox_virtual_environment_group.this[each.value.group.name].group_id
  path      = each.value.acl.path
  role_id   = each.value.acl.role_id
  propagate = each.value.acl.propagate
}

################################################################
# Users
################################################################
locals {
  user_acls = { for item in flatten([
    for user in var.users : [
      for acl in user.acls : {
        user = user
        acl  = acl
      }
    ]
  ]) : "${item.user.username}/${item.acl.path}/${item.acl.role_id}" => item }
}

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
}

resource "proxmox_acl" "user" {
  for_each = local.user_acls

  user_id   = proxmox_virtual_environment_user.this[each.value.user.username].user_id
  path      = each.value.acl.path
  role_id   = each.value.acl.role_id
  propagate = each.value.acl.propagate
}

################################################################
# User Tokens
################################################################

locals {
  user_tokens = { for item in flatten([
    for user in var.users : [
      for token in user.tokens : {
        user  = user
        token = token
      }
    ]
  ]) : "${item.user.username}/${item.token.name}" => item }

  user_token_acls = { for item in flatten([
    for key, val in local.user_tokens : [
      for acl in val.token.acls : {
        user_token_key = key
        acl            = acl
      }
    ]
  ]) : "${item.user_token_key}/${item.acl.path}/${item.acl.role_id}" => item }
}

resource "proxmox_user_token" "this" {
  for_each = local.user_tokens

  user_id               = each.value.user.username
  token_name            = each.value.token.name
  comment               = each.value.token.comment
  expiration_date       = each.value.token.expiration_date
  privileges_separation = each.value.token.privileges_separation
}

resource "proxmox_acl" "user_token" {
  for_each = local.user_token_acls

  token_id  = proxmox_user_token.this[each.value.user_token_key].id
  path      = each.value.acl.path
  role_id   = each.value.acl.role_id
  propagate = each.value.acl.propagate
}
