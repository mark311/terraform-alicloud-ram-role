resource "random_uuid" "this" {
}

#############################
# ram_role
#############################
locals {
  role_name                 = var.role_name != null ? var.role_name : substr("terraform-ram-role-${replace(random_uuid.this.result, "-", "")}", 0, 32)
  admin_role_policy_name    = "AdministratorAccess"
  readonly_role_policy_name = "ReadOnlyAccess"

  trusted_principal_arns = jsonencode(var.trusted_principal_arns)
  trusted_services       = jsonencode(var.trusted_services)

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

resource "alicloud_ram_role" "this" {
  count = var.create ? 1 : 0

  name = local.role_name
  document = coalesce(
    var.trust_policy,
  (var.role_requires_mfa ? local.assume_role_with_mfa_document : local.assume_role_document))
  description = var.role_description
  force       = var.force

  max_session_duration = var.max_session_duration
}

resource "alicloud_ram_role_policy_attachment" "custom" {
  count = var.create ? length(var.managed_custom_policy_names) : 0

  role_name   = alicloud_ram_role.this[0].name
  policy_name = element(var.managed_custom_policy_names, count.index)
  policy_type = "Custom"
}

resource "alicloud_ram_role_policy_attachment" "system" {
  count = var.create ? length(var.managed_system_policy_names) : 0

  role_name   = alicloud_ram_role.this[0].name
  policy_type = "System"
  policy_name = element(var.managed_system_policy_names, count.index)
}

resource "alicloud_ram_role_policy_attachment" "admin" {
  count = var.create && var.attach_admin_policy ? 1 : 0

  role_name   = alicloud_ram_role.this[0].name
  policy_name = local.admin_role_policy_name
  policy_type = "System"
}

resource "alicloud_ram_role_policy_attachment" "readonly" {
  count = var.create && var.attach_readonly_policy ? 1 : 0

  role_name   = alicloud_ram_role.this[0].name
  policy_name = local.readonly_role_policy_name
  policy_type = "System"
}
