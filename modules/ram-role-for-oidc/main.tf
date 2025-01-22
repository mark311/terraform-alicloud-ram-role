data "alicloud_caller_identity" "current" {}

locals {
  alicloud_account_id = var.alicloud_account_id != null ? var.alicloud_account_id : data.alicloud_caller_identity.current.account_id
  # clean URLs of https:// prefix
  urls = [
    for url in compact(distinct(concat(var.provider_urls, var.provider_url != null ? [var.provider_url] : []))) :
    replace(url, "https://", "")
  ]
}

data "alicloud_ram_policy_document" "assume_role_with_oidc" {
  count = var.create ? 1 : 0

  dynamic "statement" {
    for_each = local.urls

    content {
      effect  = "Allow"
      action = ["sts:AssumeRole"]

      principal {
        entity = "Federated"
        identifiers = ["acs:ram::${local.alicloud_account_id}:oidc-provider/${statement.value}"]
      }

      dynamic "condition" {
        for_each = var.provider_trust_policy_conditions

        content {
          operator = condition.value.operator
          variable = condition.value.variable
          values   = condition.value.values
        }
      }
    }
  }
}

resource "alicloud_ram_role" "this" {
  count = var.create ? 1 : 0

  name                 = var.role_name
  max_session_duration = var.max_session_duration
  description          = var.role_description
  force                = var.force

  document = data.alicloud_ram_policy_document.assume_role_with_oidc[0].document
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
