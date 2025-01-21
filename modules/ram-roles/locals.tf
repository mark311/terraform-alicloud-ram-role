locals {
  admin_role_name     = var.admin_role_name != null ? var.admin_role_name : substr("admin-role-${replace(random_uuid.this.result, "-", "")}", 0, 32)
  poweruser_role_name = var.poweruser_role_name != null ? var.poweruser_role_name : substr("poweruser-role-${replace(random_uuid.this.result, "-", "")}", 0, 32)
  readonly_role_name  = var.readonly_role_name != null ? var.readonly_role_name : substr("readonly-role-${replace(random_uuid.this.result, "-", "")}", 0, 32)

  action                = jsonencode(var.action)
  trusted_principal_arns = jsonencode(var.trusted_principal_arns)
  trusted_services      = jsonencode(var.trusted_services)

  assume_role_document = <<EOF
		{
            "Statement": [
                {
                    "Action": ${local.action},
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
                    "Action": ${local.action},
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
