data "alicloud_account" "default" {
}
resource "random_uuid" "default" {
}

resource "alicloud_ram_user" "default" {
  name  = "tfexample"
  force = var.force
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
      policy_names = join(",", module.ram_policy.this_policy_name)
    }
  ]

}

module "ram_policy" {
  source = "terraform-alicloud-modules/ram-policy/alicloud"
  policies = [
    {
      name            = substr("terraform-ram-role-${replace(random_uuid.default.result, "-", "")}", 0, 32)
      defined_actions = join(",", ["slb-all", "vpc-all", "vswitch-all"])
      actions         = join(",", ["vpc:AssociateEipAddress", "vpc:UnassociateEipAddress"])
      resources       = join(",", ["acs:vpc:*:*:eip/eip-12345", "acs:slb:*:*:*"])
    },
    {
      name      = substr("terraform-ram-role-deny-${replace(random_uuid.default.result, "-", "")}", 0, 32)
      actions   = join(",", ["ecs:ModifyInstanceAttribute", "vpc:ModifyVpc", "vswitch:ModifyVSwitch"])
      resources = join(",", ["acs:ecs:*:*:instance/i-001", "acs:vpc:*:*:vpc/v-001", "acs:vpc:*:*:vswitch/vsw-001"])
      effect    = "Deny"
    }
  ]
}