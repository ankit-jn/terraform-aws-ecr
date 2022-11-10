data aws_kms_key "this" {
    for_each = { for repository in var.repositories: 
                        repository.name => repository.kms_key 
                            if lookup(repository, "enable_encryption", false) && 
                                lookup(repository, "encryption_type", "AES256") == "KMS"}

    key_id = each.value
}

data template_file "policy_template" {
    for_each = { for repository in var.repositories: 
                    repository.name => repository.policy_file 
                        if lookup(repository, "attach_policy", false)}

    template = file("${path.root}/${each.value}")
}

data template_file "lifecycle_policy_template" {

    for_each = { for repository in var.repositories: 
                        repository.name => repository.lifecycle_policy_file 
                            if lookup(repository, "create_lifecycle_policy", false)}

    template = file("${path.root}/${each.value}")
}
