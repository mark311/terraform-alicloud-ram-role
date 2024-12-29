# Admin
output "admin_ram_role_arn" {
  description = "ARN of admin RAM role"
  value       = module.ram-assumable-roles-example.admin_ram_role_arn
}

output "admin_ram_role_name" {
  description = "Name of admin RAM role"
  value       = module.ram-assumable-roles-example.admin_ram_role_name
}

output "admin_ram_role_id" {
  description = "ID of admin RAM role"
  value       = module.ram-assumable-roles-example.admin_ram_role_id
}

output "admin_ram_role_requires_mfa" {
  description = "Whether admin RAM role requires MFA"
  value       = module.ram-assumable-roles-example.admin_ram_role_requires_mfa
}

# Poweruser
output "poweruser_ram_role_arn" {
  description = "ARN of poweruser RAM role"
  value       = module.ram-assumable-roles-example.poweruser_ram_role_arn
}

output "poweruser_ram_role_name" {
  description = "Name of admin RAM role"
  value       = module.ram-assumable-roles-example.poweruser_ram_role_name
}

output "poweruser_ram_role_id" {
  description = "ID of poweruser RAM role"
  value       = module.ram-assumable-roles-example.poweruser_ram_role_id
}

output "poweruser_ram_role_requires_mfa" {
  description = "Whether poweruser RAM role requires MFA"
  value       = module.ram-assumable-roles-example.poweruser_ram_role_requires_mfa
}

# Readonly
output "readonly_ram_role_arn" {
  description = "ARN of readonly RAM role"
  value       = module.ram-assumable-roles-example.readonly_ram_role_arn
}

output "readonly_ram_role_name" {
  description = "Name of admin RAM role"
  value       = module.ram-assumable-roles-example.readonly_ram_role_name
}

output "readonly_ram_role_id" {
  description = "ID of readonly RAM role"
  value       = module.ram-assumable-roles-example.readonly_ram_role_id
}

output "readonly_ram_role_requires_mfa" {
  description = "Whether readonly RAM role requires MFA"
  value       = module.ram-assumable-roles-example.readonly_ram_role_requires_mfa
}
