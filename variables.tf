variable "repositories" {
    description = <<EOF
List of Repositories where each entry will be a map of repository configurations

name                : Name of the repository.
                      (Required)

force_delete        : Flag to decide if it will delete the repository even if it contains images
                      (Optional, default `false`) 

image_tag_mutability: The tag mutability setting for the repository.
                      (Optional, default `MUTABLE`) 

enable_encryption   : Flag to decide if Images stored in repository should be encrypted
                      (Optional, default `false`)

encryption_type     : The encryption type to use for the repository.
                      (Optional, default `AES256` if `enable_encryption` is set true)

kms_key             : The reference of the KMS key to use when encryption_type is KMS
                      (Optional) 
                      key Reference could be either of this format:

                      - 1234abcd-12ab-34cd-56ef-1234567890ab
                      - arn:aws:kms:<region>:<account no>:key/1234abcd-12ab-34cd-56ef-1234567890ab
                      - alias/my-key
                      - arn:aws:kms:<region>:<account no>:alias/my-key

enable_image_scan   : Flag to decide if images are scanned after being pushed to the repository
                      (optional, default `false`)

create_lifecycle_policy : Flag to decide if Lifecycle policy should be attached to ECR repository
                          (Optional, default `false`)
lifecycle_policy_file   : Lifecycle Policy File name; Policy content to be add to the lifecycle policy 
                          will be read from the JSON document `<lifecycle_policy_file>` 
                          from the directory "policies" under root directory. 

attach_policy       : Flag to decide if policy should be attached to ECR repository
                      (Optional, default `false`)
policy_file         : Policy File name; Policy content to be add to the lifecycle policy 
                      will be read from the JSON document `<policy_file>` 
                      from the directory "policies" under root directory. 

tags                : A map of tags to assign to the repository.
                      (Optional)

EOF
    type = list(any)
    default = [
        {
            name = "first-repo"
            tags = {
                "Application" = "My First Application"
            }
        }
    ]
}

variable "default_tags" {
    description = "(Optional) A map of tags to assign to all the resource."
    type = map(string)
    default = {
        "CostCenter" = "1234"
    }
}