locals {
  resource_name_prefix = "tfmod-ram-role-custom-trust-policy"
}

resource "random_integer" "default" {
  min = 0
  max = 99999
}

module "example" {
  source = "../.."

  create           = true
  role_name        = "${local.resource_name_prefix}-${random_integer.default.result}-example"
  role_description = "${local.resource_name_prefix}-${random_integer.default.result}-example"

  role_requires_mfa   = false
  attach_admin_policy = true

  trust_policy = <<EOF
  {
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Effect": "Allow",
        "Principal": {
            "Service": ["fc.aliyuncs.com"]
        }
      }
    ],
      "Version": "1"
  }
  EOF

}
