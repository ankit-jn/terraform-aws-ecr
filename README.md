# ARJ-Stack: Elastic Container Registry Repository Terraform module

A Terraform module for provisioning Elastic Container Registry Repository

## Resources
This module features the following components to be provisioned with different combinations:

- Elastic Container Registry Repository [[aws_ecr_repository](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository)]
- ECR Repository Policy [[aws_ecr_repository_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository_policy)]
- ECR Lifecycle Policy [[aws_ecr_lifecycle_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_lifecycle_policy)]

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.22.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.22.0 |

## Examples

Refer [Configuration Examples](https://github.com/arjstack/terraform-aws-examples/tree/main/aws-ecr) for effectively utilizing this module.

## Inputs
---

- Policy content to be add to the lifecycle policy will be read from the JSON document `<lifecycle_policy_file>` from the directory "policies" under root directory.
- Policy content to be add to the lifecycle policy will be read from the JSON document `<policy_file>` from the directory "policies" under root directory.

| Name | Description | Type | Default | Required | Example|
|:------|:------|:------|:------|:------:|:------|
| <a name="name"></a> [name](#input\_name) | Name of the repository. | `string` |  | yes |  |
| <a name="force_delete"></a> [force_delete](#input\_force_delete) | Flag to decide if it will delete the repository even if it contains images | `bool` | `false` | no |  |
| <a name="image_tag_mutability"></a> [image_tag_mutability](#input\_image_tag_mutability) | The tag mutability setting for the repository. | `string` | `MUTABLE` | no |  |
| <a name="enable_encryption"></a> [enable_encryption](#input\_enable_encryption) | Flag to decide if Images stored in repository should be encrypted | `bool` | `false` | no |  |
| <a name="encryption_type"></a> [encryption_type](#input\_encryption_type) | The encryption type to use for the repository. | `string` | `AES256` | no |  |
| <a name="kms_key"></a> [kms_key](#input\_kms_key) | The reference of the KMS key to use when encryption_type is KMS.<br>key Reference could be either of this format:<br>&nbsp;&nbsp;- `1234abcd-12ab-34cd-56ef-1234567890ab`<br>&nbsp;&nbsp;- `arn:aws:kms:<region>:<account no>:key/1234abcd-12ab-34cd-56ef-1234567890ab`<br>&nbsp;&nbsp;- `alias/my-key`<br>&nbsp;&nbsp;- `arn:aws:kms:<region>:<account no>:alias/my-key` | `string` |  | no |  |
| <a name="enable_image_scan"></a> [enable_image_scan](#input\_enable_image_scan) | Flag to decide if images are scanned after being pushed to the repository | `bool` | `false` | no |  |
| <a name="create_lifecycle_policy"></a> [create_lifecycle_policy](#input\_create_lifecycle_policy) | Flag to decide if Lifecycle policy should be attached to ECR repository | `bool` | `false` | no |  |
| <a name="lifecycle_policy_file"></a> [lifecycle_policy_file](#input\_lifecycle_policy_file) | Lifecycle Policy File name with path relative to root directory if `create_lifecycle_policy` is set `true` i.e. `policies/custom_policy.json`. | `string` |  | no |  |
| <a name="attach_policy"></a> [attach_policy](#input\_attach_policy) | Flag to decide if policy should be attached to ECR repository | `bool` | `false` | no |  |
| <a name="policy_file"></a> [policy_file](#input\_policy_file) | Policy File name with path relative to root directory if `attach_policy` is set `true`. | `string` |  | no |  |
| <a name="tags"></a> [tags](#input\_tags) | A map of tags to assign to the repository. | `map(string)` | `{}` | no |  |

## Outputs

| Name | Type | Description |
|:------|:------|:------|
| <a name="ecr_configs"></a> [ecr_configs](#output\_ecr\_configs) |  `map` | Map of ECR repository configs<br>&nbsp;&nbsp;&nbsp;<b>Map Key:</b> Repository Name<br>&nbsp;&nbsp;&nbsp;<b>Map Value:</b><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`arn`: Full ARN of the repository.<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`registry_id`: The registry ID where the repository was created.<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`repository_url`:  The URL of the repository |

## Authors

Module is maintained by [Ankit Jain](https://github.com/ankit-jn) with help from [these professional](https://github.com/arjstack/terraform-aws-ecr/graphs/contributors).

