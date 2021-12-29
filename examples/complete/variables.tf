variable "services" {
  description = "List of the predefined and custom services used to play the ram role."
  type        = list(string)
  default     = ["ecs.aliyuncs.com", "apigateway.aliyuncs.com"]
}

variable "force" {
  description = "Whether to delete ram policy forcibly, default to true."
  type        = bool
  default     = false
}
