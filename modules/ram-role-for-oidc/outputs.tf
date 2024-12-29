output "ram_role_arn" {
  description = "ARN of RAM role"
  value       = try(alicloud_ram_role.this[0].arn, "")
}

output "ram_role_name" {
  description = "Name of RAM role"
  value       = try(alicloud_ram_role.this[0].name, "")
}

output "ram_role_id" {
  description = "ID of RAM role"
  value       = try(alicloud_ram_role.this[0].role_id, "")
}
