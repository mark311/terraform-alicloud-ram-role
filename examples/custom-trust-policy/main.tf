module "ram-assumable-role-example" {
  source = "../.."

  create = true
  role_name   = "tf-example-ram-assumable-role-custom-trust-policy"
  ram_role_description = "tf-example-ram-assumable-role-custom-trust-policy"

  role_requires_mfa         = false
  attach_admin_policy       = true

  custom_role_trust_policy = <<EOF
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
