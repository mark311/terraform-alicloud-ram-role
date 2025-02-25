locals {
  identifiers = compact(distinct(concat(var.provider_ids, var.provider_id != null ? [var.provider_id] : [])))
}

data "alicloud_ram_policy_document" "assume_role_with_saml" {
  count = var.create ? 1 : 0

  statement {
    effect = "Allow"
    action = ["sts:AssumeRole"]

    principal {
      entity      = "Federated"
      identifiers = local.identifiers
    }
  }
}

resource "alicloud_ram_role" "this" {
  count = var.create ? 1 : 0

  name                 = var.role_name
  max_session_duration = var.max_session_duration
  description          = var.role_description
  force                = var.force

  document = data.alicloud_ram_policy_document.assume_role_with_saml[0].document
}

resource "alicloud_ram_role_policy_attachment" "custom_role_policies" {
  count = var.create ? length(var.managed_custom_policy_names) : 0

  role_name   = alicloud_ram_role.this[0].name
  policy_type = "Custom"
  policy_name = element(var.managed_custom_policy_names, count.index)
}

resource "alicloud_ram_role_policy_attachment" "custom_role_system_policies" {
  count = var.create ? length(var.managed_system_policy_names) : 0

  role_name   = alicloud_ram_role.this[0].name
  policy_type = "System"
  policy_name = element(var.managed_system_policy_names, count.index)
}
