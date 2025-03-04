Terraform module which create RAM roles on Alibaba Cloud.
  
ram-role
===========================

English | [简体中文](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-role/blob/master/README-CN.md)

Terraform module used to create a custom RAM role on Alibaba Cloud, and attach several RAM policies for it. 

## Usage

Create a role named test-role, grant it the system policy AliyunOSSReadOnlyAccess to trust all RAM users, RAM role to assume it within account 123456789012\*\*\*\*.

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

Create a role named test-role, grant it the system policy AliyunOSSReadOnlyAccess, and trust the RAM user user1 and RAM role role1 to assume it in account 123456789012\*\*\*\*.

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

Create a role named test-role, grant it the system policy AliyunOSSReadOnlyAccess and trust ecs.aliyuncs.com cloud service to assume it.

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

Create a role named test-role, grant it the system policy AliyunOSSReadOnlyAccess, and trust the SAML identity provider acs:ram::123456789012\*\*\*\*:saml-provider/test-provider to assume it.
View Module [ram-role-for-saml](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-role/blob/master/modules/ram-role-for-saml) for more detailed usage guidelines.

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

## Modules

* [ram-role-for-saml](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-role/blob/master/modules/ram-role-for-saml)([example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-role/blob/master/examples/for-saml)) - Alibaba Cloud's Resource Access Management (RAM) supports [SAML Role SSO Integration](https://help.aliyun.com/zh/ram/user-guide/overview) with external identity providers. You can now efficiently create RAM resources related to SAML SSO integration using a Terraform Module.

## Examples

* [basic](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-role/blob/master/examples/basic)
* [complete](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-role/blob/master/examples/complete)
* [custom-trust-policy](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-role/blob/master/examples/custom-trust-policy)
* [for-saml](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-role/blob/master/examples/for-saml)


## Notes
From the version v2.0.0, the `services` parameter and `users` parameter have been removed from this Module, and you can set the trusted entities of the roles via the `trusted_services`, `trusted_principal_arns` and `trust_policy` parameters.

From the version v2.0.0, the `policies` parameter has been removed from this Module. You can grant custom and system policies to roles with the `managed_custom_policy_names` and `managed_system_policy_names` parameters, and you can grant Admin policy and read-only policy to roles with the `attach_admin_policy` parameter and the `attach_readonly_policy` parameter.

From the version v2.0.0, the `existing_role_name` parameter has been removed from this Module, you can create a RAM role with the `role_name` parameter.

From the version v1.1.0, the module has removed the following `provider` explicit settings:

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

If you still want to use the `provider` setting to apply this module, you can specify a supported version, like 1.0.0:

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

If you want to upgrade the module to 1.1.0 or higher in-place, you can define a provider which same region with
previous region:
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
Alternatively, if you have a multi-region deployment, you can define multiple providers using `alias` and explicitly specify this provider in the Module:

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

and then run `terraform init` and `terraform apply` to make the defined provider effect to the existing module state.

More details see [How to use provider in the module](https://www.terraform.io/docs/language/modules/develop/providers.html#passing-providers-explicitly)

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
| [alicloud_ram_role.this](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ram_role) | resource |
| [alicloud_ram_role_policy_attachment.admin](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ram_role_policy_attachment) | resource |
| [alicloud_ram_role_policy_attachment.custom](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ram_role_policy_attachment) | resource |
| [alicloud_ram_role_policy_attachment.readonly](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ram_role_policy_attachment) | resource |
| [alicloud_ram_role_policy_attachment.system](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ram_role_policy_attachment) | resource |
| [random_uuid.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_attach_admin_policy"></a> [attach\_admin\_policy](#input\_attach\_admin\_policy) | Whether to attach an admin policy to a role | `bool` | `false` | no |
| <a name="input_attach_readonly_policy"></a> [attach\_readonly\_policy](#input\_attach\_readonly\_policy) | Whether to attach a readonly policy to a role | `bool` | `false` | no |
| <a name="input_create"></a> [create](#input\_create) | Whether to create ram role. If true, the 'users' or 'services' can not be empty | `bool` | `true` | no |
| <a name="input_force"></a> [force](#input\_force) | Whether to delete ram policy forcibly, default to true | `bool` | `true` | no |
| <a name="input_managed_custom_policy_names"></a> [managed\_custom\_policy\_names](#input\_managed\_custom\_policy\_names) | List of names of managed policies of Custom type to attach to RAM role | `list(string)` | `[]` | no |
| <a name="input_managed_system_policy_names"></a> [managed\_system\_policy\_names](#input\_managed\_system\_policy\_names) | List of names of managed policies of System type to attach to RAM role | `list(string)` | `[]` | no |
| <a name="input_max_session_duration"></a> [max\_session\_duration](#input\_max\_session\_duration) | Maximum session duration in seconds, refer to the parameter MaxSessionDuration of [CreateRole](https://api.aliyun.com/document/Ram/2015-05-01/CreateRole) | `number` | `3600` | no |
| <a name="input_role_description"></a> [role\_description](#input\_role\_description) | Description of the RAM role. | `string` | `"this role was created via terraform module ram-role."` | no |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | The name of role. If not set, a default name with prefix 'terraform-ram-role-' will be returned | `string` | `null` | no |
| <a name="input_role_requires_mfa"></a> [role\_requires\_mfa](#input\_role\_requires\_mfa) | Whether role requires MFA | `bool` | `true` | no |
| <a name="input_trust_policy"></a> [trust\_policy](#input\_trust\_policy) | A custom role trust policy. Conflicts with 'trusted\_principal\_arns' and 'trusted\_services' | `string` | `null` | no |
| <a name="input_trusted_principal_arns"></a> [trusted\_principal\_arns](#input\_trusted\_principal\_arns) | ARNs of Alibaba Cloud entities who can assume these roles. Conflicts with 'trust\_policy' | `list(string)` | `[]` | no |
| <a name="input_trusted_services"></a> [trusted\_services](#input\_trusted\_services) | Alibaba Cloud Services that can assume these roles. Conflicts with 'trust\_policy' | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_role_arn"></a> [role\_arn](#output\_role\_arn) | ARN of RAM role |
| <a name="output_role_id"></a> [role\_id](#output\_role\_id) | ID of RAM role |
| <a name="output_role_name"></a> [role\_name](#output\_role\_name) | Name of the ram role |
| <a name="output_role_requires_mfa"></a> [role\_requires\_mfa](#output\_role\_requires\_mfa) | Whether RAM role requires MFA |
<!-- END_TF_DOCS -->

Authors
-------
Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com)

License
----
Apache 2 Licensed. See LICENSE for full details.

Reference
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)