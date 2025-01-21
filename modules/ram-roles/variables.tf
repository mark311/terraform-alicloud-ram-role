variable "max_session_duration" {
  description = "Maximum session duration in seconds, refer to the parameter MaxSessionDuration of [CreateRole](https://api.aliyun.com/document/Ram/2015-05-01/CreateRole)"
  type        = number
  default     = 3600
}

# alicloud_ram_role
variable "admin_role_requires_mfa" {
  description = "Whether admin role requires MFA"
  type        = bool
  default     = true
}

variable "poweruser_role_requires_mfa" {
  description = "Whether poweruser role requires MFA"
  type        = bool
  default     = true
}

variable "readonly_role_requires_mfa" {
  description = "Whether readonly role requires MFA"
  type        = bool
  default     = true
}

variable "action" {
  description = "Operations on specific resources"
  type        = string
  default     = "sts:AssumeRole"
}

variable "trusted_principal_arns" {
  description = "ARNs of Alibaba Cloud entities who can assume these roles"
  type        = list(string)
  default     = []
}

variable "trusted_services" {
  description = "Alibaba Cloud Services that can assume these roles"
  type        = list(string)
  default     = []
}

variable "role_description" {
  description = "Description of the RAM role"
  type        = string
  default     = ""
}

variable "force" {
  description = "This parameter is used for resource destroy"
  type        = bool
  default     = false
}

# Admin
variable "create_admin_role" {
  description = "Whether to create admin role"
  type        = bool
  default     = false
}

variable "admin_role_name" {
  description = "RAM role with admin access. If not set, a default name with prefix `admin-role-` will be returned."
  type        = string
  default     = ""
}

variable "admin_role_policy_names" {
  description = "List of policy names to use for admin role"
  type        = list(string)
  default     = []
}

# Poweruser
variable "create_poweruser_role" {
  description = "Whether to create poweruser role"
  type        = bool
  default     = false
}

variable "poweruser_role_name" {
  description = "RAM role with poweruser access. If not set, a default name with prefix `poweruser-role-` will be returned."
  type        = string
  default     = ""
}

variable "poweruser_role_policy_names" {
  description = "List of policy names to use for poweruser role"
  type        = list(string)
  default     = []
}

# Readonly
variable "create_readonly_role" {
  description = "Whether to create readonly role"
  type        = bool
  default     = false
}

variable "readonly_role_name" {
  description = "RAM role with readonly access. If not set, a default name with prefix `readonly-role-` will be returned."
  type        = string
  default     = ""
}

variable "readonly_role_policy_names" {
  description = "List of policy names to use for readonly role"
  type        = list(string)
  default     = []
}
