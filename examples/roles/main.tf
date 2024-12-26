######################
# ram assumable roles
######################
data "alicloud_account" "this" {
}

module "ram-assumable-roles-example" {
  source = "../../modules/roles"

  create_admin_role          = true
  create_readonly_role       = true

  admin_role_name            = "tf-example-ram-assumable-roles-basic-admin"
  readonly_role_name         = "tf-example-ram-assumable-roles-basic-readonly"

  max_session_duration       = 7200

  trusted_role_arns = [
    "acs:ram::${data.alicloud_account.this.id}:root"
  ]
  trusted_role_services = [
    "ecs.aliyuncs.com"
  ]
}
