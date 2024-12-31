# Admin
output "admin_role_arn" {
  description = "ARN of admin RAM role"
  value       = element(concat(alicloud_ram_role.admin.*.arn, [""]), 0)
}

output "admin_role_name" {
  description = "Name of admin RAM role"
  value       = element(concat(alicloud_ram_role.admin.*.name, [""]), 0)
}

output "admin_role_id" {
  description = "ID of admin RAM role"
  value       = try(alicloud_ram_role.admin[0].role_id, "")
}

output "admin_role_requires_mfa" {
  description = "Whether admin RAM role requires MFA"
  value       = var.admin_role_requires_mfa
}

# Poweruser
output "poweruser_role_arn" {
  description = "ARN of poweruser RAM role"
  value       = element(concat(alicloud_ram_role.poweruser.*.arn, [""]), 0)
}

output "poweruser_role_name" {
  description = "Name of admin RAM role"
  value       = element(concat(alicloud_ram_role.poweruser.*.name, [""]), 0)
}

output "poweruser_role_id" {
  description = "ID of poweruser RAM role"
  value       = try(alicloud_ram_role.poweruser[0].role_id, "")
}

output "poweruser_role_requires_mfa" {
  description = "Whether poweruser RAM role requires MFA"
  value       = var.poweruser_role_requires_mfa
}

# Readonly
output "readonly_role_arn" {
  description = "ARN of readonly RAM role"
  value       = element(concat(alicloud_ram_role.readonly.*.arn, [""]), 0)
}

output "readonly_role_name" {
  description = "Name of admin RAM role"
  value       = element(concat(alicloud_ram_role.readonly.*.name, [""]), 0)
}

output "readonly_role_id" {
  description = "ID of readonly RAM role"
  value       = try(alicloud_ram_role.readonly[0].role_id, "")
}

output "readonly_role_requires_mfa" {
  description = "Whether readonly RAM role requires MFA"
  value       = var.readonly_role_requires_mfa
}
