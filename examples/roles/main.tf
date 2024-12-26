locals {
  resource_name_prefix = "tfmod-ram-role-roles"
}

######################
# ram assumable roles
######################
data "alicloud_account" "this" {
}

module "ram-assumable-roles-example" {
  source = "../../modules/roles"

  create_admin_role          = true
  create_readonly_role       = true

  admin_role_name            = "${local.resource_name_prefix}-example-admin"
  readonly_role_name         = "${local.resource_name_prefix}-example-readonly"

  max_session_duration       = 7200

  trusted_role_arns = [
    "acs:ram::${data.alicloud_account.this.id}:root"
  ]
  trusted_role_services = [
    "ecs.aliyuncs.com"
  ]
}
