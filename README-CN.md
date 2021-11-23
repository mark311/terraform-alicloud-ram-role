terraform-alicloud-ram-role
===========================

Terraform模块用于在阿里云上创建自定义RAM角色并为其绑定RAM Policy。

支持以下类型的资源：

* [RAM role](https://www.terraform.io/docs/providers/alicloud/r/ram_role.html)
* [RAM role attachment](https://www.terraform.io/docs/providers/alicloud/r/ram_role_attachment.html)

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

## 注意事项
本Module从版本v1.1.0开始已经移除掉如下的 provider 的显示设置：

```hcl
provider "alicloud" {
  version                 = ">=1.64.0"
  profile                 = var.profile != "" ? var.profile : null
  shared_credentials_file = var.shared_credentials_file != "" ? var.shared_credentials_file : null
  region                  = var.region != "" ? var.region : null
  skip_region_validation  = var.skip_region_validation
  configuration_source    = "terraform-alicloud-modules/ram-role"
}
```

如果你依然想在Module中使用这个 provider 配置，你可以在调用Module的时候，指定一个特定的版本，比如 1.0.0:

```hcl
module "ram_role" {
  source  = "terraform-alicloud-modules/ram-role/alicloud"
  version = "1.0.0"
  region  = "cn-shenzhen"
  profile = "Your-Profile-Name"
  name    = "test-role"
  force   = true
  // ...
}
```

如果你想对正在使用中的Module升级到 1.1.0 或者更高的版本，那么你可以在模板中显示定义一个系统过Region的provider：
```hcl
provider "alicloud" {
  region  = "cn-shenzhen"
  profile = "Your-Profile-Name"
}
module "ram_role" {
  source  = "terraform-alicloud-modules/ram-role/alicloud"
  name    = "test-role"
  force   = true
  // ...
}
```
或者，如果你是多Region部署，你可以利用 `alias` 定义多个 provider，并在Module中显示指定这个provider：

```hcl
provider "alicloud" {
  region  = "cn-shenzhen"
  profile = "Your-Profile-Name"
  alias   = "sz"
}
module "ram_role" {
  source  = "terraform-alicloud-modules/ram-role/alicloud"
  providers         = {
    alicloud = alicloud.sz
  }
  name    = "test-role"
  force   = true
  // ...
}
```

定义完provider之后，运行命令 `terraform init` 和 `terraform apply` 来让这个provider生效即可。

更多provider的使用细节，请移步[How to use provider in the module](https://www.terraform.io/docs/language/modules/develop/providers.html#passing-providers-explicitly)

## Terraform 版本

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.0 |

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

