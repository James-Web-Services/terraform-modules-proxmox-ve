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
  value = try([
    for v in proxmox_virtual_environment_vm.this.ipv4_addresses : v if length(v) == 1 && !contains(v, "127.0.0.1")
  ][0][0], null)
}

output "mac_address" {
  description = "The MAC address."
  value = try([
    for v in proxmox_virtual_environment_vm.this.mac_addresses : v if v != "00:00:00:00:00:00"
  ][0], null)
}

output "user_cloud_init_snippet_file_name" {
  description = "The file name of the user cloud-init snippet."
  value       = try(proxmox_virtual_environment_file.user_cloud_init[0].file_name, null)
}
