output "role_arn" {
  description = "ARN of RAM role"
  value       = module.ram-assumable-role-with-saml-example.role_arn
}

output "role_name" {
  description = "Name of RAM role"
  value       = module.ram-assumable-role-with-saml-example.role_name
}

output "role_id" {
  description = "ID of RAM role"
  value       = module.ram-assumable-role-with-saml-example.role_id
}
