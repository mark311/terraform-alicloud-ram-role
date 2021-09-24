Terraform module which create RAM roles on Alibaba Cloud.  
terraform-alicloud-ram-role

=====================================================================

English | [简体中文](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-role/blob/master/README-CN.md)

Terraform module used to create a RAM role on Alibaba Cloud, and attach several RAM policies for it. 

These types of resources are supported:

* [RAM role](https://www.terraform.io/docs/providers/alicloud/r/ram_role.html)
* [RAM role attachment](https://www.terraform.io/docs/providers/alicloud/r/ram_role_attachment.html)

## Terraform versions

The Module requires Terraform 0.12.

## Usage

#### Create policy using terraform default actions 

```hcl
module "ram_role" {
  source = "terraform-alicloud-modules/ram-role/alicloud"
  name   = "test-role"
  users = [
    # Add a trusted user under a specified account.
    {
      user_names = join(",", ["user3", "user4"])
      account_id = "123456789012****"
    },
    # If not set `account_id`, the default is the current account.
    {
      user_names = join(",", ["user1", "user2"])
    }
  ]
  # Setting predefined or custom services
  services = ["ecs", "apigateway", "oss.aliyuncs.com", "ecs-cn-hangzhou.aliyuncs.com"]
  force    = true
  policies = [
    # Binding a system policy.
    {
      policy_names = ["AliyunVPCFullAccess","AliyunKafkaFullAccess"]
      policy_type  = "System"
    },
    # When binding custom policy, make sure this policy has been created.
    {
      policy_names = ["VpcListTagResources", "RamPolicyForZhangsan"]
      policy_type  = "Custom"
    },
    # Create Custom policy and bind the ram role.
    {
      policy_names = module.ram_policy.this_policy_name
    }
  ]
}

module "ram_policy" {
  source = "terraform-alicloud-modules/ram-policy/alicloud"
  policies = [
    {
      name            = "manage-slb-and-eip-resource"
      defined_actions = join(",", ["slb-all", "vpc-all", "vswitch-all"])
      actions         = join(",", ["vpc:AssociateEipAddress", "vpc:UnassociateEipAddress"])
      resources       = join(",", ["acs:vpc:*:*:eip/eip-12345", "acs:slb:*:*:*"])
    },
    {
      #actions is the action of custom specific resource.
      #resources is the specific object authorized to customize.
      actions   = join(",", ["ecs:ModifyInstanceAttribute", "vpc:ModifyVpc", "vswitch:ModifyVSwitch"])
      resources = join(",", ["acs:ecs:*:*:instance/i-001", "acs:vpc:*:*:vpc/v-001", "acs:vpc:*:*:vswitch/vsw-001"])
      effect    = "Deny"
    }
  ]
}
```


## Examples

* [complete example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-role/tree/master/examples/complete)

Authors
-------
Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com)

License
----
Apache 2 Licensed. See LICENSE for full details.

Reference
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)

