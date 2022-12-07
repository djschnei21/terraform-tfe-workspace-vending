terraform {
  required_providers {
    tfe = {
      version = "~> 0.38.0"
    }
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
}

provider "tfe" {}

variable "app_ids" {
    type = list(string)
    default = []
}

variable "app_envs" {
  type = list(string)
  default = ["development", "uat", "production"]
}

module "repos" {
    source = "./modules/repo"

    for_each = var.app_ids
    app_id = each.key
    app_envs = var.app_envs
}

module "workspaces" {
    source = "./modules/workspace"
    depends_on = [
      module.repos
    ]

    for_each = var.app_ids
    app_id = each.key
    app_envs = var.app_envs
}