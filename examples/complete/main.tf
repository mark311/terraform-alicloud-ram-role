
module "ram_policy" {
  source = "terraform-alicloud-modules/ram-policy/alicloud"
  policies = [
    {
      name            = "tf-manage-slb-and-eip-resource"
      defined_actions = join(",", ["slb-all", "vpc-all", "vswitch-all"])
      actions         = join(",", ["vpc:AssociateEipAddress", "vpc:UnassociateEipAddress"])
      resources       = join(",", ["acs:vpc:*:*:eip/eip-12345", "acs:slb:*:*:*"])
    },
    {
      #actions is the action of custom specific resource.
      #resources is the specific object authorized to customize.
      name            = "tf-manage-slb-and-eip-resource"
      actions   = join(",", ["ecs:ModifyInstanceAttribute", "vpc:ModifyVpc", "vswitch:ModifyVSwitch"])
      resources = join(",", ["acs:ecs:*:*:instance/i-001", "acs:vpc:*:*:vpc/v-001", "acs:vpc:*:*:vswitch/vsw-001"])
      effect    = "Deny"
    }
  ]
}

resource "alicloud_ram_user" "user" {
  name         = "tf_user_test_ram_user_001"
  display_name = "user_display_name"
  mobile       = "86-18688888888"
  email        = "hello.uuu@aaa.com"
  comments     = "yoyoyo"
  force        = true
}

module "ram_role" {
  source              = "../../"
  create              = true
  role_name           = "tf-test-role-name-001"
  users               = [{user_names = alicloud_ram_user.user.name}]
  services            = var.services
  force               = var.force
}

module "ram_role1" {
  source              = "../../"
  create              = false
  existing_role_name  = module.ram_role.this_role_name
  policies            = [
    # Binding a system policy.
    {
      policy_names = join(",", ["AliyunVPCFullAccess", "AliyunKafkaFullAccess"])
      policy_type  = "System"
    },
    # Create policy and bind the ram role.
    {
      policy_names = join(",", module.ram_policy.this_policy_name)
    }
  ]

}
