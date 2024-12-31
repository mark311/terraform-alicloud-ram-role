data "alicloud_account" "this" {
}

resource "random_uuid" "this" {
}

#############################
# ram_role
#############################
locals {
  # assert that sets trust policy in correct way
  trust_style_1 = signum(length(var.users) + length(var.services))
  trust_style_2 = signum(length(var.trusted_principal_arns) + length(var.trusted_services))
  trust_style_3 = signum(length(var.trust_policy))
  used_style_array = [local.trust_style_1, local.trust_style_2, local.trust_style_3]
  assert_atmost_one_style_used = sum(local.used_style_array) <= 1 ? true : file(
    "Error: not allow to mix these 3 kinds of variables: 1) users, services; 2) trusted_principal_arns, trusted_services; 3) trust_policy")
  assert_atleast_one_style_used_or_existing_role = sum(local.used_style_array) > 0 || var.existing_role_name != "" ? true : file(
    "Error: no trust policy set, use variable trusted_principal_arns, trusted_services or trust_policy to set one")

  # assert that there's no variable 'existing_role_name' set when using trust_style_2 and trust_style_3
  assert_not_coexist_of_existing_role_name_and_trust_style_2_and_3 = (var.existing_role_name == "" || local.trust_style_2 + local.trust_style_3 == 0) ? true : file(
    "Error: not allow to mix these 2 kinds of variables: 1) existing_role_name; 2) trusted_principal_arns, trusted_services, trust_policy")

  # control which roles to create
  create_role_this = length(var.users) > 0
  create_role_service = length(var.services) > 0
  create_role_this2 = local.trust_style_2 + local.trust_style_3 > 0

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
  this_role_name = var.existing_role_name != "" ? var.existing_role_name : concat(
    alicloud_ram_role.this.*.name,
    alicloud_ram_role.service.*.name,
    alicloud_ram_role.this2.*.name,
    [""])[0]
}

resource "alicloud_ram_role" "this" {
  count       = var.create && local.create_role_this && length(var.services) == 0 ? 1 : 0
  name        = local.role_name
  document    = <<EOF
		{
		  "Statement": [
			{
			  "Action": "sts:AssumeRole",
			  "Effect": "Allow",
			  "Principal": {
                  "RAM":${jsonencode(length(var.users) != 0 ? local.trusted_user : ["acs:ram::${data.alicloud_account.this.id}:root"])}
			  }
			}
		  ],
		  "Version": "1"
		}
	  EOF
  description = var.ram_role_description
  force       = var.force
}

resource "alicloud_ram_role" "service" {
  count       = var.create && local.create_role_service && length(var.services) != 0 ? 1 : 0
  name        = local.role_name
  document    = <<EOF
		{
		  "Statement": [
			{
			  "Action": "sts:AssumeRole",
			  "Effect": "Allow",
			  "Principal": {
				"Service": ${jsonencode(local.defined_services)}
			  }
			}
		  ],
		  "Version": "1"
		}
	  EOF
  description = var.ram_role_description
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
  count = var.create ? length(local.policy_list) : 0

  role_name   = local.this_role_name
  policy_name = lookup(local.policy_list[count.index], "policy_name")
  policy_type = lookup(local.policy_list[count.index], "policy_type")
}


#########################################################
# style 2 and style 3 to set trust policy
#########################################################

locals {
  admin_role_policy_name      = "AdministratorAccess"
  readonly_role_policy_name   = "ReadOnlyAccess"

  trusted_principal_arns      = jsonencode(var.trusted_principal_arns)
  trusted_services            = jsonencode(var.trusted_services)
  mfa_age                     = jsonencode(var.mfa_age)

  assume_role_document = <<EOF
		{
            "Statement": [
                {
                    "Action": "sts:AssumeRole",
                    "Effect": "Allow",
                    "Principal": {
                        "RAM": ${local.trusted_principal_arns},
                        "Service": ${local.trusted_services}
                    }
                }
            ],
              "Version": "1"
		}
	  EOF

  assume_role_with_mfa_document = <<EOF
		{
             "Statement": [
                {
                    "Action": "sts:AssumeRole",
                    "Effect": "Allow",
                    "Principal": {
                        "RAM": ${local.trusted_principal_arns},
                        "Service": ${local.trusted_services}
                    },
                    "Condition": {
                        "Bool": {
                            "acs:MFAPresent": ["true"]
                        }
                    }
                }
            ],
              "Version": "1"
		}
	  EOF
}

resource "alicloud_ram_role" "this2" {
  count = var.create && local.create_role_this2 ? 1 : 0

  name        = local.role_name
  document    = coalesce(
    var.trust_policy,
    (var.role_requires_mfa ? local.assume_role_with_mfa_document : local.assume_role_document))
  description = var.ram_role_description
  force       = var.force

  max_session_duration = var.max_session_duration
}

resource "alicloud_ram_role_policy_attachment" "custom" {
  count = var.create && local.create_role_this2 ? length(var.managed_custom_policy_names) : 0

  role_name   = alicloud_ram_role.this2[0].name
  policy_name = element(var.managed_custom_policy_names, count.index)
  policy_type = "Custom"
}

resource "alicloud_ram_role_policy_attachment" "system" {
  count = var.create && local.create_role_this2 ? length(var.managed_system_policy_names) : 0

  role_name   = alicloud_ram_role.this2[0].name
  policy_type = "System"
  policy_name = element(var.managed_system_policy_names, count.index)
}

resource "alicloud_ram_role_policy_attachment" "admin" {
  count = var.create && local.create_role_this2 && var.attach_admin_policy ? 1 : 0

  role_name   = alicloud_ram_role.this2[0].name
  policy_name = local.admin_role_policy_name
  policy_type = "System"
}

resource "alicloud_ram_role_policy_attachment" "readonly" {
  count = var.create && local.create_role_this2 && var.attach_readonly_policy ? 1 : 0

  role_name   = alicloud_ram_role.this2[0].name
  policy_name = local.readonly_role_policy_name
  policy_type = "System"
}
