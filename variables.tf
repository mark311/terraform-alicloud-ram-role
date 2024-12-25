variable "region" {
  description = "(Deprecated from version 1.1.0) The region used to launch this module resources."
  type        = string
  default     = ""
}

variable "profile" {
  description = "(Deprecated from version 1.1.0) The profile name as set in the shared credentials file. If not set, it will be sourced from the ALICLOUD_PROFILE environment variable."
  type        = string
  default     = ""
}
variable "shared_credentials_file" {
  description = "(Deprecated from version 1.1.0) This is the path to the shared credentials file. If this is not set and a profile is specified, $HOME/.aliyun/config.json will be used."
  type        = string
  default     = ""
}

variable "skip_region_validation" {
  description = "(Deprecated from version 1.1.0) Skip static validation of region ID. Used by users of alternative AlibabaCloud-like APIs or users w/ access to regions that are not public (yet)."
  type        = bool
  default     = false
}

# ram_role
variable "create" {
  description = "Whether to create ram role. If true, the 'users' or 'services' can not be empty."
  type        = bool
  default     = true
}

variable "force_new_style" {
  description = "Force to use new style of create role. New style using variables 'trusted_role_arns', 'trusted_role_services', 'managed_custom_policy_names', 'managed_system_policy_names' and etc. "
  type        = bool
  default     = false
}

variable "role_name" {
  description = "The name of role. If not set, a default name with prefix 'terraform-ram-role-' will be returned. "
  type        = string
  default     = ""
}

variable "existing_role_name" {
  description = "(Deprecated) The name of an existing RAM role. If set, 'create' will be ignored."
  type        = string
  default     = ""
}

variable "services" {
  description = "(Deprecated, use variable 'trusted_role_services' instead) List of the predefined and custom services used to play the ram role."
  type        = list(string)
  default     = []
}

variable "users" {
  description = "(Deprecated, use variable 'trusted_role_arns' instead) List of the trusted users. Each item can contains keys: 'user_names'(list name of RAM users), 'account_id'(the account id of ram users). If not set 'account_id', the default is the current account. It will ignored when setting services."
  type        = list(map(string))
  default     = []
}

variable "ram_role_description" {
  description = "Description of the RAM role."
  type        = string
  default     = ""
}

variable "force" {
  description = "Whether to delete ram policy forcibly, default to true."
  type        = bool
  default     = true
}

# ram_role_policy_attachment
variable "policies" {
  description = "(Deprecated, use variable 'managed_custom_policy_names' or 'managed_system_policy_names' instead) List of the policies that binds the role. Each item can contains keys: 'policy_name'(the name of policy that used to bind the role), 'policy_type'(the type of ram policies, System or Custom, default to Custom.)."
  type        = list(map(string))
  default     = []
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

variable "mfa_age" {
  description = "Max age of valid MFA (in seconds) for roles which require MFA"
  type        = number
  default     = 86400
}

variable "trusted_role_arns" {
  description = "ARNs of Alibaba Cloud entities who can assume these roles"
  type        = list(string)
  default     = []
}

variable "trusted_role_services" {
  description = "Alibaba Cloud Services that can assume these roles"
  type        = list(string)
  default     = []
}

variable "custom_role_trust_policy" {
  description = "A custom role trust policy. Conflicts with 'trusted_role_arns' and 'trusted_role_services'"
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
