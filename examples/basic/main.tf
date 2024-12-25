data "alicloud_account" "this" {
}

module "ram-assumable-role-example" {
  source = "../.."

  create = true
  role_name   = "tf-example-ram-assumable-role-basic"
  ram_role_description = "tf-example-ram-assumable-role-basic"

  role_requires_mfa         = false
  attach_admin_policy       = true
  attach_readonly_policy    = true

  trusted_role_arns = [
    "acs:ram::${data.alicloud_account.this.id}:root"
  ]
  trusted_role_services = [
    "ecs.aliyuncs.com"
  ]
}
