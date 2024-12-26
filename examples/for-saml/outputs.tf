output "ram_role_arn" {
  description = "ARN of RAM role"
  value       = module.ram-assumable-role-with-saml-example.ram_role_arn
}

output "ram_role_name" {
  description = "Name of RAM role"
  value       = module.ram-assumable-role-with-saml-example.ram_role_name
}

output "ram_role_id" {
  description = "ID of RAM role"
  value       = module.ram-assumable-role-with-saml-example.ram_role_id
}
