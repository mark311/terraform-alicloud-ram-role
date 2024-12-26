data "alicloud_account" "default" {
}

locals {
  resource_name_prefix = "tfmod-ram-role-complete"
}

resource "random_uuid" "default" {
}

resource "alicloud_ram_user" "default" {
  name  = "tfexample"
  force = var.force
}

resource "alicloud_ram_policy" "custom-policy-1" {
  policy_name     = "${local.resource_name_prefix}-custom-policy-1"
  policy_document = <<EOF
	{
		"Version": "1",
		"Statement": [
		  {
			"Action": "ecs:*",
			"Resource": "*",
			"Effect": "Allow"
		  }
		]
	  }
	EOF
}

module "ram_role" {
  source = "../.."

  create = true

  services = var.services
  users = [
    {
      user_names = alicloud_ram_user.default.name
      account_id = data.alicloud_account.default.id
    }
  ]
  ram_role_description = var.ram_role_description
  force                = var.force

}

module "use_existing_role" {
  source = "../.."

  create             = false
  existing_role_name = module.ram_role.this_role_name

  policies = [
    {
      policy_names = join(",", ["AliyunVPCFullAccess", "AliyunKafkaFullAccess"])
      policy_type  = "System"
    },
    {
      policy_names = join(",", [alicloud_ram_policy.custom-policy-1.policy_name])
    }
  ]

}
