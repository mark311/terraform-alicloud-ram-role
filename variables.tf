variable "region" {
  description = "The region used to launch this module resources."
  type        = string
  default     = ""
}

variable "profile" {
  description = "The profile name as set in the shared credentials file. If not set, it will be sourced from the ALICLOUD_PROFILE environment variable."
  type        = string
  default     = ""
}
variable "shared_credentials_file" {
  description = "This is the path to the shared credentials file. If this is not set and a profile is specified, $HOME/.aliyun/config.json will be used."
  type        = string
  default     = ""
}

variable "skip_region_validation" {
  description = "Skip static validation of region ID. Used by users of alternative AlibabaCloud-like APIs or users w/ access to regions that are not public (yet)."
  type        = bool
  default     = false
}

variable "create" {
  description = "Whether to bind role and policy. If false, this role will no policy."
  type        = bool
  default     = true
}

variable "name" {
  description = "The name of role. If not set, a default name with prefix `terraform-ram-role-` will be returned. "
  type        = string
  default     = ""
}

variable "users" {
  description = "List of the trusted users. Each item can include the following field:`user_names`(RAM user under the designated AliCloud account),`account_id`(designated AliCloud account), if not set `account_id`, the default is the current account. If not set all, current account number all ram users can play the role."
  type        = list(map(string))
  default     = []
}

variable "services" {
  description = "List of the defined services used to play the ram role."
  type        = list(string)
  default     = []
}

variable "force" {
  description = "Whether to delete ram policy forcibly, default to true."
  type        = bool
  default     = true
}

variable "policies" {
  description = "List of the policies that binds the role. Each item can include the following field:`policy_name`(the name of policy that binds the role), `policy_type`(the type of policy that binds the role)."
  type = list(object({
    policy_names = list(string)
    policy_type  = string
  }))
  default = []
}