output "this_role_name" {
  description = "Name of the ram role"
  value       = alicloud_ram_role.this.name
}

output "this_role_trusted_users" {
  description = "RAM users who can play this role"
  value       = alicloud_ram_role.this.*.ram_users
}

output "this_role_trusted_services" {
  description = "AliCloud services who can play this role"
  value       = alicloud_ram_role.this.*.services
}