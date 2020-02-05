provider "alicloud" {
  version                 = ">=1.64.0"
  profile                 = var.profile != "" ? var.profile : null
  shared_credentials_file = var.shared_credentials_file != "" ? var.shared_credentials_file : null
  region                  = var.region != "" ? var.region : null
  skip_region_validation  = var.skip_region_validation
  configuration_source    = "terraform-alicloud-modules/ram-role"
}

data "alicloud_account" "this" {}
resource "random_uuid" "this" {}

#############################
# ram_role
#############################
locals {
  create           = var.existing_role_name != "" ? false : var.create
  attach_policy    = var.existing_role_name != "" || var.create ? true : false
  role_name        = var.role_name != "" ? var.role_name : substr("terraform-ram-role-${replace(random_uuid.this.result, "-", "")}", 0, 32)
  defined_services = distinct(flatten([for _, service in var.services : lookup(var.defined_services, service, [service])]))

  trusted_user_list = flatten(
    [
      for _, obj in var.users : [
        for _, name in split(",", obj["user_names"]) : {
          user_name  = name
          account_id = lookup(obj, "account_id", "") != "" ? lookup(obj, "account_id", "") : data.alicloud_account.this.id
        }
      ]
    ]
  )
  trusted_user   = flatten([for _, user in local.trusted_user_list : formatlist("acs:ram::${lookup(user, "account_id")}:user/%s", lookup(user, "user_name"))])
  this_role_name = var.existing_role_name != "" ? var.existing_role_name : concat(alicloud_ram_role.this.*.name, [""])[0]
}

resource "alicloud_ram_role" "this" {
  count       = local.create ? 1 : 0
  name        = local.role_name
  document    = <<EOF
		{
		  "Statement": [
			{
			  "Action": "sts:AssumeRole",
			  "Effect": "Allow",
			  "Principal": {
				"Service": ${jsonencode(local.defined_services)},
                  "RAM":${jsonencode(length(var.users) != 0 ? local.trusted_user : ["acs:ram::${data.alicloud_account.this.id}:root"])}
			  }
			}
		  ],
		  "Version": "1"
		}
	  EOF
  description = "An Ram Role created by terraform-alicloud-modules/ram-role"
  force       = var.force
}

#############################
# ram_role_policy_attachment
#############################
locals {
  policy_list = flatten(
    [
      for _, obj in var.policies : [
        for _, name in distinct(flatten(split(",", obj["policy_names"]))) : {
          policy_name = name
          policy_type = lookup(obj, "policy_type", "Custom")
        }
      ]
    ]
  )
}

resource "alicloud_ram_role_policy_attachment" "this" {
  count = local.attach_policy ? length(local.policy_list) : 0

  role_name   = local.this_role_name
  policy_name = lookup(local.policy_list[count.index], "policy_name")
  policy_type = lookup(local.policy_list[count.index], "policy_type")
}