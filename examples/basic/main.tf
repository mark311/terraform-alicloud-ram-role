locals {
  resource_name_prefix = "tfmod-ram-role-basic"
}

resource "random_integer" "default" {
  min = 0
  max = 99999
}

data "alicloud_account" "this" {
}

module "example" {
  source = "../.."

  create           = true
  role_name        = "${local.resource_name_prefix}-${random_integer.default.result}-example"
  role_description = "${local.resource_name_prefix}-${random_integer.default.result}-example"

  role_requires_mfa      = false
  attach_admin_policy    = true
  attach_readonly_policy = true

  trusted_principal_arns = [
    "acs:ram::${data.alicloud_account.this.id}:root"
  ]
  trusted_services = [
    "ecs.aliyuncs.com"
  ]
}
