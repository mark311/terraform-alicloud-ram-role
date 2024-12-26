# RAM assumable role with SAML example

This example illustrates how to create a basic assumable role with SAML.

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

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.220.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | 1.237.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ram-assumable-role-with-saml-example"></a> [ram-assumable-role-with-saml-example](#module\_ram-assumable-role-with-saml-example) | ../../modules/ram-assumable-role-with-saml | n/a |

## Resources

| Name | Type |
|------|------|
| [alicloud_caller_identity.current](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/caller_identity) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ram_role_arn"></a> [ram\_role\_arn](#output\_ram\_role\_arn) | ARN of RAM role |
| <a name="output_ram_role_id"></a> [ram\_role\_id](#output\_ram\_role\_id) | ID of RAM role |
| <a name="output_ram_role_name"></a> [ram\_role\_name](#output\_ram\_role\_name) | Name of RAM role |
<!-- END_TF_DOCS -->
