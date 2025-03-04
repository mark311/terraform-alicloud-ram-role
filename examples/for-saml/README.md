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
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_example"></a> [example](#module\_example) | ../../modules/ram-role-for-saml | n/a |

## Resources

| Name | Type |
|------|------|
| [alicloud_ram_saml_provider.provider1](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ram_saml_provider) | resource |
| [alicloud_ram_saml_provider.provider2](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ram_saml_provider) | resource |
| [alicloud_ram_saml_provider.provider3](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ram_saml_provider) | resource |
| [random_integer.default](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_role_arn"></a> [role\_arn](#output\_role\_arn) | ARN of RAM role |
| <a name="output_role_id"></a> [role\_id](#output\_role\_id) | ID of RAM role |
| <a name="output_role_name"></a> [role\_name](#output\_role\_name) | Name of RAM role |
<!-- END_TF_DOCS -->