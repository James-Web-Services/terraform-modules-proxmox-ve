variable "groups" {
  description = "List of groups to create."

  type = list(object({
    name    = string
    comment = string

    acls = optional(list(object({
      path      = string
      role_id   = string
      propagate = optional(bool, true)
    })), [])
  }))

  default = []
}

variable "users" {
  description = "List of users to create."

  type = list(object({
    username        = string
    comment         = string
    password        = optional(string)
    first_name      = optional(string)
    last_name       = optional(string)
    email           = optional(string)
    expiration_date = optional(string)
    keys            = optional(string)
    enabled         = optional(bool, true)
    groups          = optional(list(string), [])

    acls = optional(list(object({
      path      = string
      role_id   = string
      propagate = optional(bool, true)
    })), [])

    tokens = optional(list(object({
      name                  = string
      comment               = string
      expiration_date       = optional(string)
      privileges_separation = optional(bool, false)

      acls = optional(list(object({
        path      = string
        role_id   = string
        propagate = optional(bool, true)
      })), [])
    })), [])
  }))

  default = []
}
