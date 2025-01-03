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
| [alicloud_ram_policy_document.assume_role_with_saml](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/ram_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create"></a> [create](#input\_create) | Whether to create a role | `bool` | `false` | no |
| <a name="input_force"></a> [force](#input\_force) | This parameter is used for RAM role force destroy | `bool` | `false` | no |
| <a name="input_managed_custom_policy_names"></a> [managed\_custom\_policy\_names](#input\_managed\_custom\_policy\_names) | List of names of managed policies of Custom type to attach to RAM user | `list(string)` | `[]` | no |
| <a name="input_managed_system_policy_names"></a> [managed\_system\_policy\_names](#input\_managed\_system\_policy\_names) | List of names of managed policies of System type to attach to RAM user | `list(string)` | `[]` | no |
| <a name="input_max_session_duration"></a> [max\_session\_duration](#input\_max\_session\_duration) | Maximum CLI/API session duration in seconds between 3600 and 43200 | `number` | `3600` | no |
| <a name="input_provider_id"></a> [provider\_id](#input\_provider\_id) | ID of the SAML Provider. Use provider\_ids to specify several IDs. | `string` | `""` | no |
| <a name="input_provider_ids"></a> [provider\_ids](#input\_provider\_ids) | List of SAML Provider IDs | `list(string)` | `[]` | no |
| <a name="input_ram_role_description"></a> [ram\_role\_description](#input\_ram\_role\_description) | RAM Role description | `string` | `""` | no |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | RAM role name | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_role_arn"></a> [role\_arn](#output\_role\_arn) | ARN of RAM role |
| <a name="output_role_id"></a> [role\_id](#output\_role\_id) | ID of RAM role |
| <a name="output_role_name"></a> [role\_name](#output\_role\_name) | Name of RAM role |
<!-- END_TF_DOCS -->
