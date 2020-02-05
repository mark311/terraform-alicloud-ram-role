# terraform-alicloud-ram-role
=====================================================================

中文简体 

Terraform模块可以在阿里云上创建自定义RAM角色。

支持以下类型的资源：

* [RAM role](https://www.terraform.io/docs/providers/alicloud/r/ram_role.html)

## Terraform 版本

本 Module 要求使用 Terraform 0.12.

## 用法

#### 使用Terraform默认的操作创建自定义角色

```hcl
module "ram_role" {
  source = "terraform-alicloud-modules/ram-role/alicloud"
  name   = "test-role"
  # If parameter `user` not set, current account number all ram users can play the role. 
  users = [
    # Add a trusted user under a specified account.
    {
      user_names = join(",", ["user3", "user4"])
      account_id = "123456789012****"
    },
    # If not set `account_id`, the default is the current account.
    {
      user_names = join(",", ["user1", "user2"])
    }
  ]
  services = ["ecs", "apigateway"]
  force    = true
  policies = [
    # Binding a system policy.
    {
      policy_names = ["AliyunVPCFullAccess","AliyunKafkaFullAccess"]
      policy_type  = "System"
    },
    # When binding custom policy, make sure this policy has been created.
    {
      policy_names = ["VpcListTagResources", "RamPolicyForZhangsan"]
      policy_type  = "Custom"
    },
    # Create policy and bind the ram role.
    {
      policy_names = module.ram_policy.this_policy_name
      policy_type  = "Custom"
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
```

## 示例

* [ram-role 示例](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-role/tree/master/examples/ram-role)


作者
-------
Created and maintained by Zhou qilin(z17810666992@163.com), He Guimin(@xiaozhu36, heguimin36@163.com)

许可
----
Apache 2 Licensed. See LICENSE for full details.

参考
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)

