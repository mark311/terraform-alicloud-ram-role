# RAM assumable role example

This example illustrates how to create a assumable role with trust policy customized.

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

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ram-assumable-role-example"></a> [ram-assumable-role-example](#module\_ram-assumable-role-example) | ../.. | n/a |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_role_arn"></a> [role\_arn](#output\_role\_arn) | ARN of RAM role |
| <a name="output_role_id"></a> [role\_id](#output\_role\_id) | ID of RAM role |
| <a name="output_role_name"></a> [role\_name](#output\_role\_name) | Name of RAM role |
| <a name="output_role_requires_mfa"></a> [role\_requires\_mfa](#output\_role\_requires\_mfa) | Whether RAM role requires MFA |
| <a name="output_this_role_trusted_services"></a> [this\_role\_trusted\_services](#output\_this\_role\_trusted\_services) | (Deprecated) AliCloud services who can play this role. Works with variable 'services' |
| <a name="output_this_role_trusted_users"></a> [this\_role\_trusted\_users](#output\_this\_role\_trusted\_users) | (Deprecated) RAM users who can play this role. Works with variable 'users' |
<!-- END_TF_DOCS -->
