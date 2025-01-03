# Complete

Configuration in this directory will create a complete role。

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which cost money. Run `terraform destroy` when you don't need these resources.

This example provides the tf variables file in the folder `tfvars`. If you want to create or update this example,
you can run this example as the following commands:
```bash
$ terraform plan -var-file=tfvars/01-update.tfvars
$ terraform apply -var-file=tfvars/01-update.tfvars
```

Also, you can add more variables files in the folder `tfvars`.

<!-- 在根目录下运行命令 `terraform-docs markdown . --output-file "./README.md"`，可将所有信息自动填充 -->
<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | 1.239.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.6.3 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ram_role"></a> [ram\_role](#module\_ram\_role) | ../.. | n/a |
| <a name="module_use_existing_role"></a> [use\_existing\_role](#module\_use\_existing\_role) | ../.. | n/a |

## Resources

| Name | Type |
|------|------|
| [alicloud_ram_policy.custom-policy-1](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ram_policy) | resource |
| [alicloud_ram_user.default](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ram_user) | resource |
| [random_uuid.default](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) | resource |
| [alicloud_account.default](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/data-sources/account) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_force"></a> [force](#input\_force) | Whether to delete ram policy forcibly, default to true. | `bool` | `false` | no |
| <a name="input_ram_role_description"></a> [ram\_role\_description](#input\_ram\_role\_description) | Description of the RAM role. | `string` | `"tf-testacc-role-description"` | no |
| <a name="input_services"></a> [services](#input\_services) | List of the predefined and custom services used to play the ram role. | `list(string)` | <pre>[<br/>  "ecs",<br/>  "apigateway"<br/>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_role_name"></a> [role\_name](#output\_role\_name) | Name of the ram role |
| <a name="output_this_role_trusted_services"></a> [this\_role\_trusted\_services](#output\_this\_role\_trusted\_services) | AliCloud services who can play this role |
| <a name="output_this_role_trusted_users"></a> [this\_role\_trusted\_users](#output\_this\_role\_trusted\_users) | RAM users who can play this role |
<!-- END_TF_DOCS -->
