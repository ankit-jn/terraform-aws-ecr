output "ecr_configs" {
    description = "ARN of the ECR repositories"
    value = { 
        for repository in aws_ecr_repository.this : 
            repository.key => 
                {
                    arn             = repository.arn
                    registry_id     = repository.registry_id
                    repository_url  = repository.repository_url
                }
    }
}
