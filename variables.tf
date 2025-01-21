variable "create" {
  description = "Whether to create ram role. If true, the 'users' or 'services' can not be empty."
  type        = bool
  default     = true
}

variable "role_name" {
  description = "The name of role. If not set, a default name with prefix 'terraform-ram-role-' will be returned. "
  type        = string
  default     = ""
}

variable "role_description" {
  description = "Description of the RAM role."
  type        = string
  default     = ""
}

variable "force" {
  description = "Whether to delete ram policy forcibly, default to true."
  type        = bool
  default     = true
}

variable "max_session_duration" {
  description = "Maximum session duration in seconds, refer to the parameter MaxSessionDuration of [CreateRole](https://api.aliyun.com/document/Ram/2015-05-01/CreateRole)"
  type        = number
  default     = 3600
}

variable "role_requires_mfa" {
  description = "Whether role requires MFA"
  type        = bool
  default     = true
}

variable "trusted_principal_arns" {
  description = "ARNs of Alibaba Cloud entities who can assume these roles. Conflicts with 'trust_policy'"
  type        = list(string)
  default     = []
}

variable "trusted_services" {
  description = "Alibaba Cloud Services that can assume these roles. Conflicts with 'trust_policy'"
  type        = list(string)
  default     = []
}

variable "trust_policy" {
  description = "A custom role trust policy. Conflicts with 'trusted_principal_arns' and 'trusted_services'"
  type        = string
  default     = ""
}

variable "managed_custom_policy_names" {
  description = "List of names of managed policies of Custom type to attach to RAM role"
  type        = list(string)
  default     = []
}

variable "managed_system_policy_names" {
  description = "List of names of managed policies of System type to attach to RAM role"
  type        = list(string)
  default     = []
}

variable "attach_admin_policy" {
  description = "Whether to attach an admin policy to a role"
  type        = bool
  default     = false
}

variable "attach_readonly_policy" {
  description = "Whether to attach a readonly policy to a role"
  type        = bool
  default     = false
}
