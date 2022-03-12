# ram_role
variable "services" {
  description = "List of the predefined and custom services used to play the ram role."
  type        = list(string)
  default     = ["ecs", "apigateway"]
}

variable "ram_role_description" {
  description = "Description of the RAM role."
  type        = string
  default     = "tf-testacc-role-description"
}

variable "force" {
  description = "Whether to delete ram policy forcibly, default to true."
  type        = bool
  default     = false
}