terraform-alicloud-ram-role
===========================

该Terraform模块用于在阿里云上创建自定义RAM角色并为其绑定RAM Policy。

## 用法

创建一个名为 test-role 的角色，授予其系统策略 AliyunOSSReadOnlyAccess ，信任账号 123456789012\*\*\*\* 内的所有RAM用户、RAM角色扮演。

```hcl
module "ram_role" {
  source = "terraform-alicloud-modules/ram-role/alicloud"
  role_name = "test-role"
  managed_system_policy_names = [
    "AliyunOSSReadOnlyAccess"
  ]
  trusted_principal_arns = [
    "acs:ram::123456789012****:root"
  ]
}
```

创建一个名为 test-role 的角色，授予其系统策略 AliyunOSSReadOnlyAccess ，信任账号 123456789012\*\*\*\* 内的RAM用户user1、RAM角色role1 扮演。

```hcl
module "ram_role" {
  source = "terraform-alicloud-modules/ram-role/alicloud"
  role_name = "test-role"
  managed_system_policy_names = [
    "AliyunOSSReadOnlyAccess"
  ]
  trusted_principal_arns = [
    "acs:ram::123456789012****:user/user1",
    "acs:ram::123456789012****:role/role1"
  ]
}
```

创建一个名为 test-role 的角色，授予其系统策略 AliyunOSSReadOnlyAccess ，信任 ecs.aliyuncs.com 云服务扮演。

```hcl
module "ram_role" {
  source = "terraform-alicloud-modules/ram-role/alicloud"
  role_name = "test-role"
  managed_system_policy_names = [
    "AliyunOSSReadOnlyAccess"
  ]
  trusted_services = [
    "ecs.aliyuncs.com"
  ]
}
```

创建一个名为 test-role 的角色，授予其系统策略 AliyunOSSReadOnlyAccess ，信任 SAML 身份提供商 acs:ram::123456789012\*\*\*\*:saml-provider/test-provider 扮演。
查看模块 [ram-role-for-saml](./modules/ram-role-for-oidc) 的 README 文档获得更详细的用法指引。

```hcl
module "ram_role" {
  source = "terraform-alicloud-modules/ram-role/alicloud"
  role_name = "test-role"
  managed_system_policy_names = [
    "AliyunOSSReadOnlyAccess"
  ]
  provider_id = "acs:ram::123456789012****:saml-provider/test-provider"
}
```

创建一个名为 test-role 的角色，授予其系统策略 AliyunOSSReadOnlyAccess ，信任 OIDC 身份提供商 acs:ram::123456789012\*\*\*\*:oidc-provider/test-provider 扮演

```hcl
module "ram_role" {
  source = "terraform-alicloud-modules/ram-role/alicloud"
  role_name = "test-role"
  managed_system_policy_names = [
    "AliyunOSSReadOnlyAccess"
  ]
  provider_url = "https://dev-xxxxxx.okta.com"
}
```

## 模块

* [ram-role-for-oidc](./modules/ram-role-for-oidc)
* [ram-role-for-saml](./modules/ram-role-for-oidc)
* [ram-roles](./modules/ram-roles)

## 示例

* [basic](./examples/basic)
* [complete](./examples/complete)
* [complete-new](./examples/complete-new)
* [custom-trust-policy](./examples/custom-trust-policy)
* [for-oidc](./examples/for-oidc)
* [for-saml](./examples/for-saml)
* [roles](./examples/roles)


## 注意事项
本Module从版本v1.1.0开始已经移除掉如下的 provider 的显式设置：

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

如果你想对正在使用中的Module升级到 1.1.0 或者更高的版本，那么你可以在模板中显式定义一个相同Region的provider：
```hcl
provider "alicloud" {
  region  = "cn-shenzhen"
  profile = "Your-Profile-Name"
}
module "ram_role" {
  source  = "terraform-alicloud-modules/ram-role/alicloud"
  role_name    = "test-role"
  force   = true
  // ...
}
```
或者，如果你是多Region部署，你可以利用 `alias` 定义多个 provider，并在Module中显式指定这个provider：

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
  role_name    = "test-role"
  force   = true
  // ...
}
```

定义完provider之后，运行命令 `terraform init` 和 `terraform apply` 来让这个provider生效即可。

更多provider的使用细节，请移步[How to use provider in the module](https://www.terraform.io/docs/language/modules/develop/providers.html#passing-providers-explicitly)

<!-- 在根目录下运行命令 `terraform-docs markdown . --output-file "./README.md"`，可将所有信息自动填充 -->
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_ram_role.service](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ram_role) | resource |
| [alicloud_ram_role.this](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ram_role) | resource |
| [alicloud_ram_role.this2](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ram_role) | resource |
| [alicloud_ram_role_policy_attachment.admin](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ram_role_policy_attachment) | resource |
| [alicloud_ram_role_policy_attachment.custom](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ram_role_policy_attachment) | resource |
| [alicloud_ram_role_policy_attachment.readonly](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ram_role_policy_attachment) | resource |
| [alicloud_ram_role_policy_attachment.system](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ram_role_policy_attachment) | resource |
| [alicloud_ram_role_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ram_role_policy_attachment) | resource |
| [random_uuid.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) | resource |
| [alicloud_account.this](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/data-sources/account) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_attach_admin_policy"></a> [attach\_admin\_policy](#input\_attach\_admin\_policy) | Whether to attach an admin policy to a role | `bool` | `false` | no |
| <a name="input_attach_readonly_policy"></a> [attach\_readonly\_policy](#input\_attach\_readonly\_policy) | Whether to attach a readonly policy to a role | `bool` | `false` | no |
| <a name="input_create"></a> [create](#input\_create) | Whether to create ram role. If true, the 'users' or 'services' can not be empty. | `bool` | `true` | no |
| <a name="input_defined_services"></a> [defined\_services](#input\_defined\_services) | Trusted physical user who can play ram\_role | `map(list(string))` | <pre>{<br/>  "actiontrail": [<br/>    "actiontrail.aliyuncs.com"<br/>  ],<br/>  "adb": [<br/>    "adb.aliyuncs.com"<br/>  ],<br/>  "alikafka": [<br/>    "alikafka.aliyuncs.com"<br/>  ],<br/>  "apigateway": [<br/>    "apigateway.aliyuncs.com"<br/>  ],<br/>  "appms": [<br/>    "appms.aliyuncs.com"<br/>  ],<br/>  "arms": [<br/>    "arms.aliyuncs.com"<br/>  ],<br/>  "baas": [<br/>    "baas.aliyuncs.com"<br/>  ],<br/>  "business": [<br/>    "business.aliyuncs.com"<br/>  ],<br/>  "ccc": [<br/>    "ccc.aliyuncs.com"<br/>  ],<br/>  "cloudpush": [<br/>    "cloudpush.aliyuncs.com"<br/>  ],<br/>  "cusanalytic": [<br/>    "cusanalytic.aliyuncs.com"<br/>  ],<br/>  "dcdn": [<br/>    "dcdn.aliyuncs.com"<br/>  ],<br/>  "ddosbgp": [<br/>    "ddosbgp.aliyuncs.com"<br/>  ],<br/>  "dns": [<br/>    "dns.aliyuncs.com"<br/>  ],<br/>  "drds": [<br/>    "drds.aliyuncs.com"<br/>  ],<br/>  "ecs": [<br/>    "ecs.aliyuncs.com"<br/>  ],<br/>  "elasticsearch": [<br/>    "elasticsearch.aliyuncs.com"<br/>  ],<br/>  "emr": [<br/>    "emr.aliyuncs.com"<br/>  ],<br/>  "ess": [<br/>    "ess.aliyuncs.com"<br/>  ],<br/>  "foas": [<br/>    "foas.aliyuncs.com"<br/>  ],<br/>  "green": [<br/>    "green.aliyuncs.com"<br/>  ],<br/>  "hbase": [<br/>    "hbase.aliyuncs.com"<br/>  ],<br/>  "iot": [<br/>    "iot.aliyuncs.com"<br/>  ],<br/>  "live": [<br/>    "live.aliyuncs.com"<br/>  ],<br/>  "market": [<br/>    "market.aliyuncs.com"<br/>  ],<br/>  "maxcompute": [<br/>    "maxcompute.aliyuncs.com"<br/>  ],<br/>  "mongodb": [<br/>    "mongodb.aliyuncs.com"<br/>  ],<br/>  "ons": [<br/>    "ons.aliyuncs.com"<br/>  ],<br/>  "polardb": [<br/>    "polardb.aliyuncs.com"<br/>  ],<br/>  "qualitycheck": [<br/>    "qualitycheck.aliyuncs.com"<br/>  ],<br/>  "r-kvstore": [<br/>    "r-kvstore.aliyuncs.com"<br/>  ],<br/>  "rds": [<br/>    "rds.aliyuncs.com"<br/>  ],<br/>  "reid": [<br/>    "reid.aliyuncs.com"<br/>  ],<br/>  "scdn": [<br/>    "scdn.aliyuncs.com"<br/>  ],<br/>  "slb": [<br/>    "slb.aliyuncs.com"<br/>  ],<br/>  "vod": [<br/>    "vod.aliyuncs.com"<br/>  ],<br/>  "vpc": [<br/>    "vpc.aliyuncs.com"<br/>  ],<br/>  "webplus": [<br/>    "webplus.aliyuncs.com"<br/>  ]<br/>}</pre> | no |
| <a name="input_existing_role_name"></a> [existing\_role\_name](#input\_existing\_role\_name) | (Deprecated) The name of an existing RAM role. If set, 'create' will be ignored. | `string` | `""` | no |
| <a name="input_force"></a> [force](#input\_force) | Whether to delete ram policy forcibly, default to true. | `bool` | `true` | no |
| <a name="input_managed_custom_policy_names"></a> [managed\_custom\_policy\_names](#input\_managed\_custom\_policy\_names) | List of names of managed policies of Custom type to attach to RAM role | `list(string)` | `[]` | no |
| <a name="input_managed_system_policy_names"></a> [managed\_system\_policy\_names](#input\_managed\_system\_policy\_names) | List of names of managed policies of System type to attach to RAM role | `list(string)` | `[]` | no |
| <a name="input_max_session_duration"></a> [max\_session\_duration](#input\_max\_session\_duration) | Maximum session duration in seconds, refer to the parameter MaxSessionDuration of [CreateRole](https://api.aliyun.com/document/Ram/2015-05-01/CreateRole) | `number` | `3600` | no |
| <a name="input_mfa_age"></a> [mfa\_age](#input\_mfa\_age) | Max age of valid MFA (in seconds) for roles which require MFA | `number` | `86400` | no |
| <a name="input_policies"></a> [policies](#input\_policies) | (Deprecated, use variable 'managed\_custom\_policy\_names' or 'managed\_system\_policy\_names' instead) List of the policies that binds the role. Each item can contains keys: 'policy\_name'(the name of policy that used to bind the role), 'policy\_type'(the type of ram policies, System or Custom, default to Custom.). | `list(map(string))` | `[]` | no |
| <a name="input_profile"></a> [profile](#input\_profile) | (Deprecated from version 1.1.0) The profile name as set in the shared credentials file. If not set, it will be sourced from the ALICLOUD\_PROFILE environment variable. | `string` | `""` | no |
| <a name="input_ram_role_description"></a> [ram\_role\_description](#input\_ram\_role\_description) | Description of the RAM role. | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | (Deprecated from version 1.1.0) The region used to launch this module resources. | `string` | `""` | no |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | The name of role. If not set, a default name with prefix 'terraform-ram-role-' will be returned. | `string` | `""` | no |
| <a name="input_role_requires_mfa"></a> [role\_requires\_mfa](#input\_role\_requires\_mfa) | Whether role requires MFA | `bool` | `true` | no |
| <a name="input_services"></a> [services](#input\_services) | (Deprecated, use variable 'trusted\_services' instead) List of the predefined and custom services used to play the ram role. | `list(string)` | `[]` | no |
| <a name="input_shared_credentials_file"></a> [shared\_credentials\_file](#input\_shared\_credentials\_file) | (Deprecated from version 1.1.0) This is the path to the shared credentials file. If this is not set and a profile is specified, $HOME/.aliyun/config.json will be used. | `string` | `""` | no |
| <a name="input_skip_region_validation"></a> [skip\_region\_validation](#input\_skip\_region\_validation) | (Deprecated from version 1.1.0) Skip static validation of region ID. Used by users of alternative AlibabaCloud-like APIs or users w/ access to regions that are not public (yet). | `bool` | `false` | no |
| <a name="input_trust_policy"></a> [trust\_policy](#input\_trust\_policy) | A custom role trust policy. Conflicts with 'trusted\_principal\_arns', 'trusted\_services', 'users' and 'services' | `string` | `""` | no |
| <a name="input_trusted_principal_arns"></a> [trusted\_principal\_arns](#input\_trusted\_principal\_arns) | ARNs of Alibaba Cloud entities who can assume these roles. Conflicts with 'trust\_policy', 'users' and 'services' | `list(string)` | `[]` | no |
| <a name="input_trusted_services"></a> [trusted\_services](#input\_trusted\_services) | Alibaba Cloud Services that can assume these roles. Conflicts with 'trust\_policy', 'users' and 'services' | `list(string)` | `[]` | no |
| <a name="input_users"></a> [users](#input\_users) | (Deprecated, use variable 'trusted\_principal\_arns' instead) List of the trusted users. Each item can contains keys: 'user\_names'(list name of RAM users), 'account\_id'(the account id of ram users). If not set 'account\_id', the default is the current account. It will ignored when setting services. | `list(map(string))` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_role_arn"></a> [role\_arn](#output\_role\_arn) | ARN of RAM role |
| <a name="output_role_id"></a> [role\_id](#output\_role\_id) | ID of RAM role |
| <a name="output_role_name"></a> [role\_name](#output\_role\_name) | Name of the ram role |
| <a name="output_role_requires_mfa"></a> [role\_requires\_mfa](#output\_role\_requires\_mfa) | Whether RAM role requires MFA |
| <a name="output_this_role_name"></a> [this\_role\_name](#output\_this\_role\_name) | Name of the ram role |
| <a name="output_this_role_trusted_services"></a> [this\_role\_trusted\_services](#output\_this\_role\_trusted\_services) | (Deprecated) AliCloud services who can play this role. Works with variable 'services' |
| <a name="output_this_role_trusted_users"></a> [this\_role\_trusted\_users](#output\_this\_role\_trusted\_users) | (Deprecated) RAM users who can play this role. Works with variable 'users' |
<!-- END_TF_DOCS -->

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
