output "this_role_name" {
  description = "Name of the ram role"
  value       = local.this_role_name
}

output "this_role_trusted_users" {
  description = "(Deprecated) RAM users who can play this role. Works with variable 'users'"
  value       = alicloud_ram_role.this.*.ram_users
}

output "this_role_trusted_services" {
  description = "(Deprecated) AliCloud services who can play this role. Works with variable 'services'"
  value       = alicloud_ram_role.this.*.services
}

output "role_name" {
  description = "Name of the ram role"
  value       = local.this_role_name
}

output "role_arn" {
  description = "ARN of RAM role"
  value       = element(concat(alicloud_ram_role.this2.*.arn, [""]), 0)
}

output "role_id" {
  description = "ID of RAM role"
  value       = element(concat(alicloud_ram_role.this2.*.role_id, [""]), 0)
}

output "role_requires_mfa" {
  description = "Whether RAM role requires MFA"
  value       = var.role_requires_mfa
}
