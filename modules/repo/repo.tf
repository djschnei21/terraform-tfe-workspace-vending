terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
}

provider "github" {}

variable "app_id" {
    type = string
    default = ""
}

variable "app_envs" {
  type = set(string)
  default = []
}

resource "github_repository" "auto_repo" {
  name        = "app-${var.app_id}"
  description = "My awesome codebase"

  visibility = "public"

  template {
      owner                = "djschnei"
      repository           = "workspace-template"
      include_all_branches = true
  }
}

resource "github_branch" "auto_repo" {
  repository = github_repository.auto_repo.name
  for_each = var.app_envs

  branch     = each.key
}