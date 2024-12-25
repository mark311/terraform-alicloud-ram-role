# RAM assumable role example

This example illustrates how to create a more complicated assumable role.

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
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | 1.238.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.6.3 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ram-assumable-role-example"></a> [ram-assumable-role-example](#module\_ram-assumable-role-example) | ../../modules/ram-assumable-role | n/a |

## Resources

| Name | Type |
|------|------|
| [alicloud_ram_policy.default](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ram_policy) | resource |
| [random_integer.default](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |
| [alicloud_account.this](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/data-sources/account) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_this_ram_role_arn"></a> [this\_ram\_role\_arn](#output\_this\_ram\_role\_arn) | ARN of RAM role |
| <a name="output_this_ram_role_id"></a> [this\_ram\_role\_id](#output\_this\_ram\_role\_id) | ID of RAM role |
| <a name="output_this_ram_role_name"></a> [this\_ram\_role\_name](#output\_this\_ram\_role\_name) | Name of RAM role |
| <a name="output_this_role_requires_mfa"></a> [this\_role\_requires\_mfa](#output\_this\_role\_requires\_mfa) | Whether RAM role requires MFA |
<!-- END_TF_DOCS -->
