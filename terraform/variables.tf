variable github_token {
  type        = string
  description = "The token used to connect to github to provision a repository"
}

variable snyk_token {
  type        = string
  description = "The token used to connect to synk to scan the repository"
}

variable aws_access_key_id {
  type        = string
  description = "The access key id used to connect to AWS"
}

variable aws_secret_access_key {
  type        = string
  description = "The secret access key used to connect to AWS"
}

variable jira_url {
  type        = string
  description = "JIRA instance URL"
}

variable jira_username {
  type        = string
  description = "JIRA username"
}

variable jira_token {
  type        = string
  description = "JIRA API token"
}

variable jira_project {
  type        = string
  description = "JIRA project key"
  default     = "VER"
}