# RAM assumable roles example

Configuration in this directory creates several individual RAM roles which can be assumed from a defined list of RAM ARNs.


# Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Run `terraform destroy` when you don't need these resources.

<!-- 在根目录下运行命令 `terraform-docs markdown . --output-file "./README.md"`，可将所有信息自动填充 -->
<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | 1.236.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ram_assumable_roles"></a> [ram\_assumable\_roles](#module\_ram\_assumable\_roles) | ../../modules/ram-assumable-roles | n/a |
| <a name="module_ram_assumable_roles_with_max_session_duration"></a> [ram\_assumable\_roles\_with\_max\_session\_duration](#module\_ram\_assumable\_roles\_with\_max\_session\_duration) | ../../modules/ram-assumable-roles | n/a |
| <a name="module_ram_assumable_roles_with_none_role_created"></a> [ram\_assumable\_roles\_with\_none\_role\_created](#module\_ram\_assumable\_roles\_with\_none\_role\_created) | ../../modules/ram-assumable-roles | n/a |

## Resources

| Name | Type |
|------|------|
| [alicloud_account.this](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/data-sources/account) | data source |

## Inputs

No inputs.

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
