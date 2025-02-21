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
| <a name="module_ram-assumable-role-with-saml-example"></a> [ram-assumable-role-with-saml-example](#module\_ram-assumable-role-with-saml-example) | ../../modules/ram-role-for-saml | n/a |

## Resources

| Name | Type |
|------|------|
| [alicloud_caller_identity.current](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/caller_identity) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_role_arn"></a> [role\_arn](#output\_role\_arn) | ARN of RAM role |
| <a name="output_role_id"></a> [role\_id](#output\_role\_id) | ID of RAM role |
| <a name="output_role_name"></a> [role\_name](#output\_role\_name) | Name of RAM role |
<!-- END_TF_DOCS -->
