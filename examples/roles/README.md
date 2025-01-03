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
| <a name="module_ram-assumable-roles-example"></a> [ram-assumable-roles-example](#module\_ram-assumable-roles-example) | ../../modules/ram-roles | n/a |

## Resources

| Name | Type |
|------|------|
| [alicloud_account.this](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/data-sources/account) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_admin_role_arn"></a> [admin\_role\_arn](#output\_admin\_role\_arn) | ARN of admin RAM role |
| <a name="output_admin_role_id"></a> [admin\_role\_id](#output\_admin\_role\_id) | ID of admin RAM role |
| <a name="output_admin_role_name"></a> [admin\_role\_name](#output\_admin\_role\_name) | Name of admin RAM role |
| <a name="output_admin_role_requires_mfa"></a> [admin\_role\_requires\_mfa](#output\_admin\_role\_requires\_mfa) | Whether admin RAM role requires MFA |
| <a name="output_poweruser_role_arn"></a> [poweruser\_role\_arn](#output\_poweruser\_role\_arn) | ARN of poweruser RAM role |
| <a name="output_poweruser_role_id"></a> [poweruser\_role\_id](#output\_poweruser\_role\_id) | ID of poweruser RAM role |
| <a name="output_poweruser_role_name"></a> [poweruser\_role\_name](#output\_poweruser\_role\_name) | Name of admin RAM role |
| <a name="output_poweruser_role_requires_mfa"></a> [poweruser\_role\_requires\_mfa](#output\_poweruser\_role\_requires\_mfa) | Whether poweruser RAM role requires MFA |
| <a name="output_readonly_role_arn"></a> [readonly\_role\_arn](#output\_readonly\_role\_arn) | ARN of readonly RAM role |
| <a name="output_readonly_role_id"></a> [readonly\_role\_id](#output\_readonly\_role\_id) | ID of readonly RAM role |
| <a name="output_readonly_role_name"></a> [readonly\_role\_name](#output\_readonly\_role\_name) | Name of admin RAM role |
| <a name="output_readonly_role_requires_mfa"></a> [readonly\_role\_requires\_mfa](#output\_readonly\_role\_requires\_mfa) | Whether readonly RAM role requires MFA |
<!-- END_TF_DOCS -->
