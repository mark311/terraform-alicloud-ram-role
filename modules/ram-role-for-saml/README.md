ram-role-for-saml
=================

English | [简体中文](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-role/blob/master/modules/ram-role-for-saml/README-CN.md)

Alibaba Cloud's Resource Access Management (RAM) supports [SAML Role SSO Integration](https://help.aliyun.com/zh/ram/user-guide/overview) with external identity providers. You can now efficiently create RAM resources related to SAML SSO integration using a Terraform Module.

## Usage
This section demonstrates how to use the Terraform Module to configure RAM for SSO integration with Alibaba Cloud's IDaaS as an external identity provider.

### Prerequisites
Before starting, you'll need to prepare the following names, which will be used when configuring both IDaaS and RAM roles:

1. SAML Identity Provider Name, e.g., test-idaas-saml-provider
2. RAM Role Name, e.g., test-role-for-idaas

### Configuring IDaaS （via Console）
First, create an IDaaS instance and account by referring to the official IDaaS documentation:

+ [IDaaS - Create a Free Instance](https://help.aliyun.com/zh/idaas/eiam/getting-started/create-an-instance-for-free)
+ [IDaaS - Create an Account](https://help.aliyun.com/zh/idaas/eiam/getting-started/create-an-account)

Then, create an "Alibaba Cloud Role SSO" application by referring to the [Creating an "Alibaba Cloud Role SSO" Application](https://help.aliyun.com/zh/idaas/eiam/user-guide/alibaba-cloud-role-based-sso) documentation. Note:

1. Only configure IDaaS resources; do not configure RAM-related resources. RAM resources will be created using Terraform. The documentation is divided into five sections; complete only the first two: "Create Application" and "Configure Application SSO".
2. Be sure to use the SAML Identity Provider Name and RAM Role Name prepared earlier.

Once configured, download the IdP metadata file from the IDaaS console, which is an XML document. You will use this later to replace the corresponding XML example in the Terraform code.

![](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-role/blob/master/scripts/imgs/en_1.jpg)

### Configuring RAM
Next, we will use Terraform to create the SAML Identity Provider and RAM Role.

First, configure the Terraform execution environment. Detailed steps can be found in Alibaba Cloud's documentation: [Getting Started with Terraform](https://help.aliyun.com/zh/terraform/getting-started-with-terraform).

After setting up the Terraform environment, add the following Terraform code to your project. The value of encodedsaml_metadata_document needs to be corrected, as described later. Ensure that the saml_provider_name and role_name match the names prepared earlier and are not changed arbitrarily.

Execute the `terraform apply` command to create the SAML Identity Provider and RAM Role.

```hcl
# Create SAML Identity Provider
resource "alicloud_ram_saml_provider" "test-saml-provider" {
  description                   = "saml provider for test."

  # SAML Identity Provider Name, must match the name used in IDaaS
  saml_provider_name            = "test-idaas-saml-provider"

  # IDaaS SAML IdP metadata XML document content
  encodedsaml_metadata_document = base64encode(<<EOF
<?xml version="1.0" encoding="UTF-8"?>
<md:EntityDescriptor xmlns:md="urn:oasis:names:tc:SAML:2.0:metadata"
                     ID="SIMPCp1J9vJt142Dvg5AT2Efcn9JumMe7fau"
                     entityID="https://574b3zcn.aliyunidaas.com/api/v2/app_m6rpawvpeqcjluw7dvyhp37gzu/saml2/meta"
                     validUntil="2125-02-05T05:00:10.578Z">
...
...
...

</md:EntityDescriptor>
EOF
    )
}

# Create RAM Role
module "ram-role-for-saml-example" {
  source = "terraform-alicloud-modules/ram-role/alicloud//modules/ram-role-for-saml"

  provider_id = alicloud_ram_saml_provider.test-saml-provider.arn

  # Role Name, must match the application account name bound to the IDaaS account
  role_name = "test-role-for-idaas"

  # Policies granted to the role
  managed_system_policy_names = ["AliyunRAMReadOnlyAccess"]
}

```

You can view them in the RAM Console.

![](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-role/blob/master/scripts/imgs/en_2.jgp)

![](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-role/blob/master/scripts/imgs/en_3.jpg)

### SSO Login to Alibaba Cloud
Log in with the IDaaS user created earlier. If you don't know how to log in, refer to the IDaaS documentation [IDaaS - First Time Single Sign-On](https://help.aliyun.com/zh/idaas/eiam/getting-started/logon-and-sso).

After logging in, click on the "Alibaba Cloud Role SSO" application you just configured to access the Alibaba Cloud Console, where your identity will be the RAM role we created using Terraform.

![](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-role/blob/master/scripts/imgs/en_4.jpg)

![](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-role/blob/master/scripts/imgs/en_5.jpg)

![](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-role/blob/master/scripts/imgs/en_6.jpg)


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_ram_role.this](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ram_role) | resource |
| [alicloud_ram_role_policy_attachment.custom_role_policies](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ram_role_policy_attachment) | resource |
| [alicloud_ram_role_policy_attachment.custom_role_system_policies](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ram_role_policy_attachment) | resource |
| [alicloud_ram_policy_document.assume_role_with_saml](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/data-sources/ram_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create"></a> [create](#input\_create) | Whether to create a role | `bool` | `true` | no |
| <a name="input_force"></a> [force](#input\_force) | This parameter is used for RAM role force destroy | `bool` | `false` | no |
| <a name="input_managed_custom_policy_names"></a> [managed\_custom\_policy\_names](#input\_managed\_custom\_policy\_names) | List of names of managed policies of Custom type to attach to RAM user | `list(string)` | `[]` | no |
| <a name="input_managed_system_policy_names"></a> [managed\_system\_policy\_names](#input\_managed\_system\_policy\_names) | List of names of managed policies of System type to attach to RAM user | `list(string)` | `[]` | no |
| <a name="input_max_session_duration"></a> [max\_session\_duration](#input\_max\_session\_duration) | Maximum CLI/API session duration in seconds between 3600 and 43200 | `number` | `3600` | no |
| <a name="input_provider_id"></a> [provider\_id](#input\_provider\_id) | ID of the SAML Provider. Use provider\_ids to specify several IDs. | `string` | `null` | no |
| <a name="input_provider_ids"></a> [provider\_ids](#input\_provider\_ids) | List of SAML Provider IDs | `list(string)` | `[]` | no |
| <a name="input_role_description"></a> [role\_description](#input\_role\_description) | RAM Role description | `string` | `"this role was created via terraform module ram-role/modules/ram-role-for-saml."` | no |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | RAM role name | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_role_arn"></a> [role\_arn](#output\_role\_arn) | ARN of RAM role |
| <a name="output_role_id"></a> [role\_id](#output\_role\_id) | ID of RAM role |
| <a name="output_role_name"></a> [role\_name](#output\_role\_name) | Name of RAM role |
<!-- END_TF_DOCS -->
