output "role_name" {
  description = "Name of the ram role"
  value       = local.role_name
}

output "role_arn" {
  description = "ARN of RAM role"
  value       = element(concat(alicloud_ram_role.this.*.arn, [""]), 0)
}

output "role_id" {
  description = "ID of RAM role"
  value       = element(concat(alicloud_ram_role.this.*.role_id, [""]), 0)
}

output "role_requires_mfa" {
  description = "Whether RAM role requires MFA"
  value       = var.role_requires_mfa
}
