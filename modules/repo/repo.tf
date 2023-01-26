terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
}

variable "app_id" {
  type    = string
  description = "The ID of whatever application you want to create repos for"
}

variable "app_envs" {
  type    = set(string)
  description = "A list of strings dictating the environment specific branches that will be created"
}

variable "gh_org" {
  type    = string
  description = "The name of the GH org where your repos will be created"
}

# resource "github_repository" "base_auto_repo" {
#   name        = "${var.app_id}-lz"
#   description = "Used to provision all base infra resources for ${var.app_id} (networking, IAM, etc...)"

#   visibility = "public"

#   template {
#     owner                = var.gh_org
#     repository           = "workspace-template"
#     include_all_branches = true
#   }
# }

# resource "github_branch" "base_auto_repo" {
#   repository = github_repository.base_auto_repo.name
#   for_each   = var.app_envs

#   branch = each.key
# }

resource "github_repository" "app_auto_repo" {
  name        = "${var.app_id}-app"
  description = "Used to provision app resources for ${var.app_id}"

  visibility = "public"

  template {
    owner                = var.gh_org
    repository           = "workspace-template"
    include_all_branches = true
  }
}

resource "github_branch" "app_auto_repo" {
  repository = github_repository.app_auto_repo.name
  for_each   = var.app_envs

  branch = each.key
}