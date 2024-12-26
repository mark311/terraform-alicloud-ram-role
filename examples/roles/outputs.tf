# Admin
output "this_admin_ram_role_arn" {
  description = "ARN of admin RAM role"
  value       = module.ram-assumable-roles-example.this_admin_ram_role_arn
}

output "this_admin_ram_role_name" {
  description = "Name of admin RAM role"
  value       = module.ram-assumable-roles-example.this_admin_ram_role_name
}

output "this_admin_ram_role_id" {
  description = "ID of admin RAM role"
  value       = module.ram-assumable-roles-example.this_admin_ram_role_id
}

output "this_admin_ram_role_requires_mfa" {
  description = "Whether admin RAM role requires MFA"
  value       = module.ram-assumable-roles-example.this_admin_ram_role_requires_mfa
}

# Poweruser
output "this_poweruser_ram_role_arn" {
  description = "ARN of poweruser RAM role"
  value       = module.ram-assumable-roles-example.this_poweruser_ram_role_arn
}

output "this_poweruser_ram_role_name" {
  description = "Name of admin RAM role"
  value       = module.ram-assumable-roles-example.this_poweruser_ram_role_name
}

output "this_poweruser_ram_role_id" {
  description = "ID of poweruser RAM role"
  value       = module.ram-assumable-roles-example.this_poweruser_ram_role_id
}

output "this_poweruser_ram_role_requires_mfa" {
  description = "Whether poweruser RAM role requires MFA"
  value       = module.ram-assumable-roles-example.this_poweruser_ram_role_requires_mfa
}

# Readonly
output "this_readonly_ram_role_arn" {
  description = "ARN of readonly RAM role"
  value       = module.ram-assumable-roles-example.this_readonly_ram_role_arn
}

output "this_readonly_ram_role_name" {
  description = "Name of admin RAM role"
  value       = module.ram-assumable-roles-example.this_readonly_ram_role_name
}

output "this_readonly_ram_role_id" {
  description = "ID of readonly RAM role"
  value       = module.ram-assumable-roles-example.this_readonly_ram_role_id
}

output "this_readonly_ram_role_requires_mfa" {
  description = "Whether readonly RAM role requires MFA"
  value       = module.ram-assumable-roles-example.this_readonly_ram_role_requires_mfa
}
