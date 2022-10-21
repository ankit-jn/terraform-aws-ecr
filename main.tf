## Create ECR Repository
resource aws_ecr_repository "this" {

    for_each = { for repository in var.repositories: repository.name => repository}

    name  = each.key
    
    force_delete = lookup(each.value, "force_delete", false)
    image_tag_mutability = lookup(each.value, "image_tag_mutability", "MUTABLE")

    dynamic "encryption_configuration" {
        for_each = lookup(repository, "enable_encryption", false) ? [1] : []

        encryption_type = lookup(repository, "encryption_type", "AES256")
        kms_key = (lookup(repository, "encryption_type", "AES256") == "KMS") ? data.aws_kms_key.this[each.key].arn : null
    }

    image_scanning_configuration {
        scan_on_push = lookup(repository, "enable_image_scan", false)
    }

    tags = merge({"Name" = ecah.key}, var.default_tags, each.value.tags)
}

## Attach Policy to ECR repositories
resource aws_ecr_repository_policy "this" {
    for_each = { for repository in var.repositories: 
                    repository.name => repository.policy_file 
                        if lookup(repository, "attach_policy", false)}

    repository = aws_ecr_repository.this[each.key].name
    policy     = data.template_file.policy_template[each.key].rendered
}

## Create ECR Lifecycle Policy
resource aws_ecr_lifecycle_policy "this" {
    for_each = { for repository in var.repositories: 
                        repository.name => repository.policy_file 
                            if lookup(repository, "create_lifecycle_policy", false)}

    repository = aws_ecr_repository.this[each.key].name
    policy     = data.template_file.lifecycle_policy_template[each.key].rendered
}