provider "github" {
  token = var.github_token
}

resource "github_repository" "this" {
  name        = "security_action"
  description = "This repository stores the github action example for security scanning"
  private     = true

  depends_on = [
    module.aws
  ]
}

resource "github_actions_secret" "snyk_token" {
  repository       = github_repository.this.name
  secret_name      = "SNYK_TOKEN"
  plaintext_value  = var.snyk_token
}

resource "github_actions_secret" "aws_access_key_id" {
  repository       = github_repository.this.name
  secret_name      = "AWS_ACCESS_KEY_ID"
  plaintext_value  = var.aws_access_key_id
}

resource "github_actions_secret" "aws_secret_access_key" {
  repository       = github_repository.this.name
  secret_name      = "AWS_SECRET_ACCESS_KEY"
  plaintext_value  = var.aws_secret_access_key
}

resource "github_actions_secret" "ecr_repository_uri" {
  repository       = github_repository.this.name
  secret_name      = "ECR_REPOSITORY_URI"
  plaintext_value  = module.aws.ecr_repository_uri
}

resource "github_actions_secret" "ecr_repository_name" {
  repository       = github_repository.this.name
  secret_name      = "ECR_REPOSITORY_NAME"
  plaintext_value  = module.aws.ecr_repository_name
}

module "aws" {
  source = "./aws"
}