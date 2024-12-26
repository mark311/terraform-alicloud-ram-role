<!-- 在根目录下运行命令 `terraform-docs markdown . --output-file "./README.md"`，可将所有信息自动填充 -->
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.220.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | >= 1.220.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_ram_role.this](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_role) | resource |
| [alicloud_ram_role_policy_attachment.custom_role_policies](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_role_policy_attachment) | resource |
| [alicloud_ram_role_policy_attachment.custom_role_system_policies](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_role_policy_attachment) | resource |
| [alicloud_caller_identity.current](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/caller_identity) | data source |
| [alicloud_ram_policy_document.assume_role_with_oidc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/ram_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alicloud_account_id"></a> [alicloud\_account\_id](#input\_alicloud\_account\_id) | The AliCloud account ID where the OIDC provider lives, leave empty to use the account for the AliCloud provider | `string` | `""` | no |
| <a name="input_create_role"></a> [create\_role](#input\_create\_role) | Whether to create a role | `bool` | `false` | no |
| <a name="input_force"></a> [force](#input\_force) | This parameter is used for RAM role force destroy | `bool` | `false` | no |
| <a name="input_managed_custom_policy_names"></a> [managed\_custom\_policy\_names](#input\_managed\_custom\_policy\_names) | List of names of managed policies of Custom type to attach to RAM user | `list(string)` | `[]` | no |
| <a name="input_managed_system_policy_names"></a> [managed\_system\_policy\_names](#input\_managed\_system\_policy\_names) | List of names of managed policies of System type to attach to RAM user | `list(string)` | `[]` | no |
| <a name="input_max_session_duration"></a> [max\_session\_duration](#input\_max\_session\_duration) | Maximum CLI/API session duration in seconds between 3600 and 43200 | `number` | `3600` | no |
| <a name="input_oidc_fully_qualified_audiences"></a> [oidc\_fully\_qualified\_audiences](#input\_oidc\_fully\_qualified\_audiences) | The audience to be added to the role policy. Set to sts.aliyuncs.com for cross-account assumable role. Leave empty otherwise. | `set(string)` | `[]` | no |
| <a name="input_oidc_fully_qualified_subjects"></a> [oidc\_fully\_qualified\_subjects](#input\_oidc\_fully\_qualified\_subjects) | The fully qualified OIDC subjects to be added to the role policy | `set(string)` | `[]` | no |
| <a name="input_oidc_subjects_with_wildcards"></a> [oidc\_subjects\_with\_wildcards](#input\_oidc\_subjects\_with\_wildcards) | The OIDC subject using wildcards to be added to the role policy | `set(string)` | `[]` | no |
| <a name="input_provider_trust_policy_conditions"></a> [provider\_trust\_policy\_conditions](#input\_provider\_trust\_policy\_conditions) | [Condition constraints](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/ram_policy_document#statement-condition) applied to the trust policy | `any` | `[]` | no |
| <a name="input_provider_url"></a> [provider\_url](#input\_provider\_url) | URL of the OIDC Provider. Use provider\_urls to specify several URLs. | `string` | `""` | no |
| <a name="input_provider_urls"></a> [provider\_urls](#input\_provider\_urls) | List of URLs of the OIDC Providers | `list(string)` | `[]` | no |
| <a name="input_role_description"></a> [role\_description](#input\_role\_description) | IAM Role description | `string` | `""` | no |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | IAM role name | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ram_role_arn"></a> [ram\_role\_arn](#output\_ram\_role\_arn) | ARN of RAM role |
| <a name="output_ram_role_id"></a> [ram\_role\_id](#output\_ram\_role\_id) | ID of RAM role |
| <a name="output_ram_role_name"></a> [ram\_role\_name](#output\_ram\_role\_name) | Name of RAM role |
<!-- END_TF_DOCS -->
