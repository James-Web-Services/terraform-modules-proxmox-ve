terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.116.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}
