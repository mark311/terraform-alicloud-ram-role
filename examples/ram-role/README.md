# ram-role example

Configuration in this directory will create a complete role。


## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example will create resources which cost money. Run `terraform destroy` when you don't need these resources.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Outputs

| Name | Description |
|------|-------------|
| this\_role\_name | Name of the ram role |
| this\_role\_trusted\_users | RAM users who can play this role |
| this\_role\_trusted\_services | AliCloud services who can play this role |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->