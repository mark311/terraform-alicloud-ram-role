locals {
  resource_name_prefix = "tfmod-ram-role-custom-trust-policy"
}

module "ram-assumable-role-example" {
  source = "../.."

  create = true
  role_name   = "${local.resource_name_prefix}-example"
  ram_role_description = "${local.resource_name_prefix}-example"

  role_requires_mfa         = false
  attach_admin_policy       = true

  trust_policy = <<EOF
  {
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Effect": "Allow",
        "Principal": {
            "Service": "fc.aliyuncs.com"
        }
      }
    ],
      "Version": "1"
  }
  EOF

}
