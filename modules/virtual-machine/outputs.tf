locals {
  # This finds the index of the first IPv4 address that starts with the specified prefix.
  # We use this index to get the corresponding MAC address and IPv4 address.
  ipv4_index = one([
    for i, lst in proxmox_virtual_environment_vm.this.ipv4_addresses : i
    if anytrue([
      for ip in lst : startswith(ip, var.ipv4_cidr_prefix)
    ])
  ])
}

output "id" {
  description = "The ID."
  value       = tonumber(proxmox_virtual_environment_vm.this.id)
}

output "name" {
  description = "The name."
  value       = proxmox_virtual_environment_vm.this.name
}

output "node_name" {
  description = "The node name."
  value       = proxmox_virtual_environment_vm.this.node_name
}

output "ipv4_address" {
  description = "The IPv4 address."
  value       = one(proxmox_virtual_environment_vm.this.ipv4_addresses[local.ipv4_index])
}

output "mac_address" {
  description = "The MAC address."
  value       = proxmox_virtual_environment_vm.this.mac_addresses[local.ipv4_index]
}

output "user_cloud_init_snippet_file_name" {
  description = "The file name of the user cloud-init snippet."
  value       = try(proxmox_virtual_environment_file.user_cloud_init[0].file_name, null)
}
