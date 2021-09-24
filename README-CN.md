terraform-alicloud-ram-role
===========================

Terraform模块用于在阿里云上创建自定义RAM角色并为其绑定RAM Policy。

支持以下类型的资源：

* [RAM role](https://www.terraform.io/docs/providers/alicloud/r/ram_role.html)
* [RAM role attachment](https://www.terraform.io/docs/providers/alicloud/r/ram_role_attachment.html)

## Terraform 版本

本 Module 要求使用 Terraform 0.12.

## 用法

#### 使用Terraform默认的操作创建自定义角色

```hcl
module "ram_role" {
  source = "terraform-alicloud-modules/ram-role/alicloud"
  name   = "test-role"
  users = [
    # 添加可信用户
    {
      user_names = join(",", ["user3", "user4"])
      account_id = "123456789012****"
    },
    # 如果不指定accountID，将使用当前用户
    {
      user_names = join(",", ["user1", "user2"])
    }
  ]
  // 指定预定义的或者自定义的可信服务
  services = ["ecs", "apigateway", "oss.aliyuncs.com", "ecs-cn-hangzhou.aliyuncs.com"]
  force    = true
  policies = [
    # 绑定系统策略
    {
      policy_names = ["AliyunVPCFullAccess","AliyunKafkaFullAccess"]
      policy_type  = "System"
    },
    # 绑定自定义策略
    {
      policy_names = ["VpcListTagResources", "RamPolicyForZhangsan"]
      policy_type  = "Custom"
    },
    # 绑定自定义策略
    {
      policy_names = module.ram_policy.this_policy_name
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

* [ram-role 完整示例](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-role/tree/master/examples/complete)


作者
-------
Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com)

许可
----
Apache 2 Licensed. See LICENSE for full details.

参考
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)

