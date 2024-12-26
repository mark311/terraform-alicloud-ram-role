# Creates RAM roles.

## Usage

```hcl
module "ram_assumable_roles" {
    source  = "terraform-alicloud-modules/ram/alicloud//modules/ram-assumable-roles"
    version = "~> 1.2"

  # omitted...
}
```

<!-- 在根目录下运行命令 `terraform-docs markdown . --output-file "./README.md"`，可将所有信息自动填充 -->
<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

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
| [alicloud_ram_role.admin](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ram_role) | resource |
| [alicloud_ram_role.poweruser](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ram_role) | resource |
| [alicloud_ram_role.readonly](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ram_role) | resource |
| [alicloud_ram_role_policy_attachment.admin](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ram_role_policy_attachment) | resource |
| [alicloud_ram_role_policy_attachment.poweruser](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ram_role_policy_attachment) | resource |
| [alicloud_ram_role_policy_attachment.readonly](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ram_role_policy_attachment) | resource |
| [random_uuid.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_action"></a> [action](#input\_action) | Operations on specific resources | `string` | `"sts:AssumeRole"` | no |
| <a name="input_admin_role_name"></a> [admin\_role\_name](#input\_admin\_role\_name) | RAM role with admin access. If not set, a default name with prefix `admin-role-` will be returned. | `string` | `""` | no |
| <a name="input_admin_role_policy_names"></a> [admin\_role\_policy\_names](#input\_admin\_role\_policy\_names) | List of policy names to use for admin role | `list(string)` | `[]` | no |
| <a name="input_admin_role_requires_mfa"></a> [admin\_role\_requires\_mfa](#input\_admin\_role\_requires\_mfa) | Whether admin role requires MFA | `bool` | `true` | no |
| <a name="input_create_admin_role"></a> [create\_admin\_role](#input\_create\_admin\_role) | Whether to create admin role | `bool` | `false` | no |
| <a name="input_create_poweruser_role"></a> [create\_poweruser\_role](#input\_create\_poweruser\_role) | Whether to create poweruser role | `bool` | `false` | no |
| <a name="input_create_readonly_role"></a> [create\_readonly\_role](#input\_create\_readonly\_role) | Whether to create readonly role | `bool` | `false` | no |
| <a name="input_description"></a> [description](#input\_description) | Description of the RAM role | `string` | `""` | no |
| <a name="input_force"></a> [force](#input\_force) | This parameter is used for resource destroy | `bool` | `false` | no |
| <a name="input_max_session_duration"></a> [max\_session\_duration](#input\_max\_session\_duration) | Maximum session duration in seconds, refer to the parameter MaxSessionDuration of [CreateRole](https://api.aliyun.com/document/Ram/2015-05-01/CreateRole) | `number` | `3600` | no |
| <a name="input_mfa_age"></a> [mfa\_age](#input\_mfa\_age) | Max age of valid MFA (in seconds) for roles which require MFA | `number` | `86400` | no |
| <a name="input_poweruser_role_name"></a> [poweruser\_role\_name](#input\_poweruser\_role\_name) | RAM role with poweruser access. If not set, a default name with prefix `poweruser-role-` will be returned. | `string` | `""` | no |
| <a name="input_poweruser_role_policy_names"></a> [poweruser\_role\_policy\_names](#input\_poweruser\_role\_policy\_names) | List of policy names to use for poweruser role | `list(string)` | `[]` | no |
| <a name="input_poweruser_role_requires_mfa"></a> [poweruser\_role\_requires\_mfa](#input\_poweruser\_role\_requires\_mfa) | Whether poweruser role requires MFA | `bool` | `true` | no |
| <a name="input_profile"></a> [profile](#input\_profile) | (Deprecated from version 1.3.0)The profile name as set in the shared credentials file. If not set, it will be sourced from the ALICLOUD\_PROFILE environment variable. | `string` | `""` | no |
| <a name="input_readonly_role_name"></a> [readonly\_role\_name](#input\_readonly\_role\_name) | RAM role with readonly access. If not set, a default name with prefix `readonly-role-` will be returned. | `string` | `""` | no |
| <a name="input_readonly_role_policy_names"></a> [readonly\_role\_policy\_names](#input\_readonly\_role\_policy\_names) | List of policy names to use for readonly role | `list(string)` | `[]` | no |
| <a name="input_readonly_role_requires_mfa"></a> [readonly\_role\_requires\_mfa](#input\_readonly\_role\_requires\_mfa) | Whether readonly role requires MFA | `bool` | `true` | no |
| <a name="input_region"></a> [region](#input\_region) | (Deprecated from version 1.3.0)The region used to launch this module resources. | `string` | `""` | no |
| <a name="input_shared_credentials_file"></a> [shared\_credentials\_file](#input\_shared\_credentials\_file) | (Deprecated from version 1.3.0)This is the path to the shared credentials file. If this is not set and a profile is specified, $HOME/.aliyun/config.json will be used. | `string` | `""` | no |
| <a name="input_skip_region_validation"></a> [skip\_region\_validation](#input\_skip\_region\_validation) | (Deprecated from version 1.3.0)Skip static validation of region ID. Used by users of alternative AlibabaCloud-like APIs or users w/ access to regions that are not public (yet). | `bool` | `false` | no |
| <a name="input_trusted_role_arns"></a> [trusted\_role\_arns](#input\_trusted\_role\_arns) | ARNs of Alibaba Cloud entities who can assume these roles | `list(string)` | `[]` | no |
| <a name="input_trusted_role_services"></a> [trusted\_role\_services](#input\_trusted\_role\_services) | Alibaba Cloud Services that can assume these roles | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_this_admin_ram_role_arn"></a> [this\_admin\_ram\_role\_arn](#output\_this\_admin\_ram\_role\_arn) | ARN of admin RAM role |
| <a name="output_this_admin_ram_role_id"></a> [this\_admin\_ram\_role\_id](#output\_this\_admin\_ram\_role\_id) | ID of admin RAM role |
| <a name="output_this_admin_ram_role_name"></a> [this\_admin\_ram\_role\_name](#output\_this\_admin\_ram\_role\_name) | Name of admin RAM role |
| <a name="output_this_admin_ram_role_requires_mfa"></a> [this\_admin\_ram\_role\_requires\_mfa](#output\_this\_admin\_ram\_role\_requires\_mfa) | Whether admin RAM role requires MFA |
| <a name="output_this_poweruser_ram_role_arn"></a> [this\_poweruser\_ram\_role\_arn](#output\_this\_poweruser\_ram\_role\_arn) | ARN of poweruser RAM role |
| <a name="output_this_poweruser_ram_role_id"></a> [this\_poweruser\_ram\_role\_id](#output\_this\_poweruser\_ram\_role\_id) | ID of poweruser RAM role |
| <a name="output_this_poweruser_ram_role_name"></a> [this\_poweruser\_ram\_role\_name](#output\_this\_poweruser\_ram\_role\_name) | Name of admin RAM role |
| <a name="output_this_poweruser_ram_role_requires_mfa"></a> [this\_poweruser\_ram\_role\_requires\_mfa](#output\_this\_poweruser\_ram\_role\_requires\_mfa) | Whether poweruser RAM role requires MFA |
| <a name="output_this_readonly_ram_role_arn"></a> [this\_readonly\_ram\_role\_arn](#output\_this\_readonly\_ram\_role\_arn) | ARN of readonly RAM role |
| <a name="output_this_readonly_ram_role_id"></a> [this\_readonly\_ram\_role\_id](#output\_this\_readonly\_ram\_role\_id) | ID of readonly RAM role |
| <a name="output_this_readonly_ram_role_name"></a> [this\_readonly\_ram\_role\_name](#output\_this\_readonly\_ram\_role\_name) | Name of admin RAM role |
| <a name="output_this_readonly_ram_role_requires_mfa"></a> [this\_readonly\_ram\_role\_requires\_mfa](#output\_this\_readonly\_ram\_role\_requires\_mfa) | Whether readonly RAM role requires MFA |
<!-- END_TF_DOCS -->
