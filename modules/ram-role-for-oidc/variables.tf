variable "max_session_duration" {
  description = "Maximum CLI/API session duration in seconds between 3600 and 43200"
  type        = number
  default     = 3600
}

variable "create" {
  description = "Whether to create a role"
  type        = bool
  default     = false
}

variable "role_name" {
  description = "IAM role name"
  type        = string
  default     = null
}

variable "managed_custom_policy_names" {
  description = "List of names of managed policies of Custom type to attach to RAM user"
  type        = list(string)
  default     = []
}

variable "managed_system_policy_names" {
  description = "List of names of managed policies of System type to attach to RAM user"
  type        = list(string)
  default     = []
}

variable "force" {
  description = "This parameter is used for RAM role force destroy"
  type        = bool
  default     = false
}

variable "role_description" {
  description = "IAM Role description"
  type        = string
  default     = ""
}

variable "provider_url" {
  description = "URL of the OIDC Provider. Use provider_urls to specify several URLs."
  type        = string
  default     = ""
}

variable "provider_urls" {
  description = "List of URLs of the OIDC Providers"
  type        = list(string)
  default     = []
}

variable "alicloud_account_id" {
  description = "The AliCloud account ID where the OIDC provider lives, leave empty to use the account for the AliCloud provider"
  type        = string
  default     = ""
}

variable "oidc_fully_qualified_subjects" {
  description = "The fully qualified OIDC subjects to be added to the role policy"
  type        = set(string)
  default     = []
}

variable "oidc_subjects_with_wildcards" {
  description = "The OIDC subject using wildcards to be added to the role policy"
  type        = set(string)
  default     = []
}

variable "oidc_fully_qualified_audiences" {
  description = "The audience to be added to the role policy. Set to sts.aliyuncs.com for cross-account assumable role. Leave empty otherwise."
  type        = set(string)
  default     = []
}

variable "provider_trust_policy_conditions" {
  description = "[Condition constraints](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/ram_policy_document#statement-condition) applied to the trust policy"
  type        = any
  default     = []
}
