data "alicloud_account" "this" {
}

resource "random_uuid" "this" {
}

#############################
# ram_role
#############################
locals {
  use_new_style    = var.force_new_style || length(var.trusted_role_arns) > 0 || length(var.trusted_role_services) > 0 || var.custom_role_trust_policy != ""

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

  admin_role_policy_name      = "AdministratorAccess"
  readonly_role_policy_name   = "ReadOnlyAccess"

  trusted_role_arns     = jsonencode(var.trusted_role_arns)
  trusted_role_services = jsonencode(var.trusted_role_services)
  mfa_age               = jsonencode(var.mfa_age)

  assume_role_document = <<EOF
		{
            "Statement": [
                {
                    "Action": "sts:AssumeRole",
                    "Effect": "Allow",
                    "Principal": {
                        "RAM": ${local.trusted_role_arns},
                        "Service": ${local.trusted_role_services}
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
                        "RAM": ${local.trusted_role_arns},
                        "Service": ${local.trusted_role_services}
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

resource "alicloud_ram_role" "this" {
  count       = var.create && !local.use_new_style && length(var.services) == 0 ? 1 : 0
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
  count       = var.create && !local.use_new_style && length(var.services) != 0 ? 1 : 0
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
  count = var.create && !local.use_new_style ? length(local.policy_list) : 0

  role_name   = local.this_role_name
  policy_name = lookup(local.policy_list[count.index], "policy_name")
  policy_type = lookup(local.policy_list[count.index], "policy_type")
}


#########################################################
# new style to set trust policy and role identity policy
#########################################################

resource "alicloud_ram_role" "this2" {
  count = var.create && local.use_new_style ? 1 : 0

  name        = local.role_name
  document    = coalesce(
    var.custom_role_trust_policy,
    (var.role_requires_mfa ? local.assume_role_with_mfa_document : local.assume_role_document))
  description = var.ram_role_description
  force       = var.force

  max_session_duration = var.max_session_duration
}

resource "alicloud_ram_role_policy_attachment" "custom" {
  count = var.create && local.use_new_style ? length(var.managed_custom_policy_names) : 0

  role_name   = alicloud_ram_role.this2[0].name
  policy_name = element(var.managed_custom_policy_names, count.index)
  policy_type = "Custom"
}

resource "alicloud_ram_role_policy_attachment" "system" {
  count = var.create && local.use_new_style ? length(var.managed_system_policy_names) : 0

  role_name   = alicloud_ram_role.this2[0].name
  policy_type = "System"
  policy_name = element(var.managed_system_policy_names, count.index)
}

resource "alicloud_ram_role_policy_attachment" "admin" {
  count = var.create && local.use_new_style && var.attach_admin_policy ? 1 : 0

  role_name   = alicloud_ram_role.this2[0].name
  policy_name = local.admin_role_policy_name
  policy_type = "System"
}

resource "alicloud_ram_role_policy_attachment" "readonly" {
  count = var.create && local.use_new_style && var.attach_readonly_policy ? 1 : 0

  role_name   = alicloud_ram_role.this2[0].name
  policy_name = local.readonly_role_policy_name
  policy_type = "System"
}
