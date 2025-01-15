# Admin
output "admin_role_arn" {
  description = "ARN of admin RAM role"
  value       = module.example.admin_role_arn
}

output "admin_role_name" {
  description = "Name of admin RAM role"
  value       = module.example.admin_role_name
}

output "admin_role_id" {
  description = "ID of admin RAM role"
  value       = module.example.admin_role_id
}

output "admin_role_requires_mfa" {
  description = "Whether admin RAM role requires MFA"
  value       = module.example.admin_role_requires_mfa
}

# Poweruser
output "poweruser_role_arn" {
  description = "ARN of poweruser RAM role"
  value       = module.example.poweruser_role_arn
}

output "poweruser_role_name" {
  description = "Name of admin RAM role"
  value       = module.example.poweruser_role_name
}

output "poweruser_role_id" {
  description = "ID of poweruser RAM role"
  value       = module.example.poweruser_role_id
}

output "poweruser_role_requires_mfa" {
  description = "Whether poweruser RAM role requires MFA"
  value       = module.example.poweruser_role_requires_mfa
}

# Readonly
output "readonly_role_arn" {
  description = "ARN of readonly RAM role"
  value       = module.example.readonly_role_arn
}

output "readonly_role_name" {
  description = "Name of admin RAM role"
  value       = module.example.readonly_role_name
}

output "readonly_role_id" {
  description = "ID of readonly RAM role"
  value       = module.example.readonly_role_id
}

output "readonly_role_requires_mfa" {
  description = "Whether readonly RAM role requires MFA"
  value       = module.example.readonly_role_requires_mfa
}
