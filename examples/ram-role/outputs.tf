output "this_role_name" {
  description = "Name of the ram role"
  value       = module.ram_role.this_role_name
}

output "this_role_trusted_users" {
  description = "RAM users who can play this role"
  value       = module.ram_role.this_role_trusted_users
}

output "this_role_trusted_services" {
  description = "AliCloud services who can play this role"
  value       = module.ram_role.this_role_trusted_services
}