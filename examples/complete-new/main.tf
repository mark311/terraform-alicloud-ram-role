data "alicloud_account" "this" {
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

resource "alicloud_ram_policy" "default" {
  policy_name     = "tf-example-ram-assumable-role-complete-examplepolicy-${random_integer.default.result}"
  policy_document = <<EOF
        {
                "Version": "1",
                "Statement": [
                  {
                        "Action": "mns:*",
                        "Resource": "*",
                        "Effect": "Allow"
                  }
                ]
        }
        EOF
}

module "ram-assumable-role-example" {
  source = "../.."

  create      = true
  role_name   = "tf-example-ram-assumable-role-complete"
  ram_role_description = "tf-example-ram-assumable-role-complete"

  max_session_duration      = 7200
  role_requires_mfa         = true
  attach_admin_policy       = true
  attach_readonly_policy    = true

  managed_system_policy_names = [
    "AliyunECSReadOnlyAccess"
  ]

  managed_custom_policy_names = [
    alicloud_ram_policy.default.policy_name
  ]

  trusted_role_arns = [
    "acs:ram::${data.alicloud_account.this.id}:root"
  ]
  trusted_role_services = [
    "ecs.aliyuncs.com"
  ]
}
