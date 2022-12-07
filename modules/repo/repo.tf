terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
}

variable "app_id" {
    type = string
    default = ""
}

variable "app_envs" {
  type = set(string)
  default = []
}

variable "gh_org" {
  type = string
  default = ""
}

resource "github_repository" "network_auto_repo" {
  name        = "network-${var.app_id}"
  description = "My awesome codebase"

  visibility = "public"

  template {
      owner                = var.gh_org
      repository           = "workspace-template"
      include_all_branches = true
  }
}

resource "github_branch" "network_auto_repo" {
  repository = github_repository.network_auto_repo.name
  for_each = var.app_envs

  branch     = each.key
}

resource "github_repository" "compute_auto_repo" {
  name        = "compute-${var.app_id}"
  description = "My awesome codebase"

  visibility = "public"

  template {
      owner                = var.gh_org
      repository           = "workspace-template"
      include_all_branches = true
  }
}

resource "github_branch" "compute_auto_repo" {
  repository = github_repository.compute_auto_repo.name
  for_each = var.app_envs

  branch     = each.key
}

resource "github_repository" "storage_auto_repo" {
  name        = "storage-${var.app_id}"
  description = "My awesome codebase"

  visibility = "public"

  template {
      owner                = var.gh_org
      repository           = "workspace-template"
      include_all_branches = true
  }
}

resource "github_branch" "storage_auto_repo" {
  repository = github_repository.storage_auto_repo.name
  for_each = var.app_envs

  branch     = each.key
}