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
}

####################################################
# basic usage
####################################################
module "ram-assumable-role-with-saml-example" {
  source = "../../modules/role-for-saml"
  role_name = "tf-example-ram-assumable-role-with-saml-basic"

  create = true

  provider_id = "acs:ram::${local.account_id}:saml-provider/test-provider"
  provider_ids = [
    "acs:ram::${local.account_id}:saml-provider/test-provider-1",
    "acs:ram::${local.account_id}:saml-provider/test-provider-2",
  ]

  managed_system_policy_names = [
    "AliyunECSFullAccess",
  ]
}
