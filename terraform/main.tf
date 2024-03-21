provider "github" {
  token = var.github_token
}

resource "github_repository" "this" {
  name        = "security_action"
  description = "This repository stores the github action example for security scanning"
  private     = false

  security_and_analysis {
    # advanced_security {
    #   status = "enabled"
    # }
    secret_scanning {
      status = "enabled"
    }
  }

  depends_on = [
    module.aws
  ]
}

# Define a GitHub Environment
resource "github_repository_environment" "staging" {
  repository      = github_repository.this.name
  environment     = "staging"
  wait_timer      = 0 # Optional: Set a wait timer (in minutes) for deployments to this environment

  deployment_branch_policy {
    protected_branches = true
    custom_branch_policies = false # Set to true to allow specific branches
  }
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

resource "github_actions_secret" "jira_url" {
  repository       = github_repository.this.name
  secret_name      = "JIRA_URL"
  plaintext_value  = var.jira_url
}

resource "github_actions_secret" "jira_username" {
  repository       = github_repository.this.name
  secret_name      = "JIRA_USERNAME"
  plaintext_value  = var.jira_username
}

resource "github_actions_secret" "jira_token" {
  repository       = github_repository.this.name
  secret_name      = "JIRA_TOKEN"
  plaintext_value  = var.jira_token
}

resource "github_actions_secret" "jira_project" {
  repository       = github_repository.this.name
  secret_name      = "JIRA_PROJECT"
  plaintext_value  = var.jira_project
}


module "aws" {
  source = "./aws"
}