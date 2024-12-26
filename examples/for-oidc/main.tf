terraform {
  required_version = ">= 1.0"

  required_providers {
    alicloud = {
      source = "aliyun/alicloud"
      version = ">= 1.220.0"
    }
  }
}

data "alicloud_caller_identity" "current" {}

locals {
  account_id          = data.alicloud_caller_identity.current.account_id
  resource_name_prefix = "tfmod-ram-role-for-oidc"
}

####################################################
# admin policy
####################################################
module "ram-assumable-role-with-oidc-example" {
  source = "../../modules/role-for-oidc"
  role_name = "${local.resource_name_prefix}-example"

  create = true

  provider_url = "oidc.circleci.com/org/CIRCLECI_ORG_UUID"

  oidc_fully_qualified_audiences = ["CIRCLECI_ORG_UUID"]

  managed_system_policy_names = [
    "AliyunECSFullAccess",
  ]

  provider_trust_policy_conditions = [
    {
      operator = "StringLike"
      variable = "aws:RequestTag/Environment"
      values   = ["example"]
    }
  ]
}
