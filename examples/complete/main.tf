module "ram_role" {
  source    = "../../"
  role_name = "test-role"
  users = [
    {
      user_names = join(",", ["user1", "user2"])
    },
    {
      user_names = join(",", ["user3", "user4"])
      account_id = "123456789012****"
    }
  ]
  services = ["ecs", "apigateway", "ecs-cn-hangzhou.aliyuncs.com"]
  force    = true
  policies = [
    # Binding a system policy.
    {
      policy_names = join(",", ["AliyunVPCFullAccess", "AliyunKafkaFullAccess"])
      policy_type  = "System"
    },
    # When binding custom policy, make sure this policy has been created.
    {
      policy_names = "VpcListTagResources,RamPolicyForZhangsan"
      policy_type  = "Custom"
    },
    # Create policy and bind the ram role.
    {
      policy_names = join(",", module.ram_policy.this_policy_name)
    }
  ]
}

module "ram_policy" {
  source = "terraform-alicloud-modules/ram-policy/alicloud"
  policies = [
    {
      name            = "manage-slb-and-eip-resource"
      defined_actions = join(",", ["slb-all", "vpc-all", "vswitch-all"])
      actions         = join(",", ["vpc:AssociateEipAddress", "vpc:UnassociateEipAddress"])
      resources       = join(",", ["acs:vpc:*:*:eip/eip-12345", "acs:slb:*:*:*"])
    },
    {
      #actions is the action of custom specific resource.
      #resources is the specific object authorized to customize.
      actions   = join(",", ["ecs:ModifyInstanceAttribute", "vpc:ModifyVpc", "vswitch:ModifyVSwitch"])
      resources = join(",", ["acs:ecs:*:*:instance/i-001", "acs:vpc:*:*:vpc/v-001", "acs:vpc:*:*:vswitch/vsw-001"])
      effect    = "Deny"
    }
  ]
}