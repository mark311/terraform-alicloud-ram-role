output "this_role_name" {
  description = "Name of RAM role"
  value       = module.ram-assumable-role-example.this_role_name
}

output "this_role_trusted_users" {
  description = "(Deprecated) RAM users who can play this role. Works with variable 'users'"
  value       = module.ram-assumable-role-example.this_role_trusted_users
}

output "this_role_trusted_services" {
  description = "(Deprecated) AliCloud services who can play this role. Works with variable 'services'"
  value       = module.ram-assumable-role-example.this_role_trusted_services
}

output "this_role_arn" {
  description = "ARN of RAM role"
  value       = module.ram-assumable-role-example.this_role_arn
}

output "this_role_id" {
  description = "ID of RAM role"
  value       = module.ram-assumable-role-example.this_role_id
}

output "this_role_requires_mfa" {
  description = "Whether RAM role requires MFA"
  value       = module.ram-assumable-role-example.this_role_requires_mfa
}
