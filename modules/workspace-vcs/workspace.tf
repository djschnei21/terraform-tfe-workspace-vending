terraform {
  required_providers {
    tfe = {
      version = "~> 0.40.0"
    }
  }
}

variable "repo" {
  type    = string
  default = ""
}

variable "app_id" {
  type    = string
  default = ""
}

variable "app_envs" {
  type    = set(string)
  default = []
}

variable "gh_org" {
  type    = string
  default = ""
}

variable "tf_org" {
  type    = string
  default = ""
}

variable "oauth_client_name" {
  type    = string
  default = ""
}

variable "projects" {
  type    = bool
  default = false
}

data "tfe_oauth_client" "client" {
  organization = var.tf_org
  name         = var.oauth_client_name
}

resource "tfe_project" "project" {
  count        = var.projects == true ? 1 : 0
  organization = var.tf_org
  name         = var.app_id
}

resource "tfe_workspace" "lz_workspaces" {
  for_each = var.app_envs

  name         = "${each.key}-${var.app_id}-lz"
  organization = var.tf_org
  project_id   = var.projects == true ? tfe_project.project[0].id : null
  tag_names    = [var.app_id, each.key]

  vcs_repo {
    identifier     = "${var.gh_org}/${var.app_id}-lz"
    branch         = each.key
    oauth_token_id = data.tfe_oauth_client.client.oauth_token_id
  }
}

resource "tfe_workspace" "app_workspaces" {
  for_each = var.app_envs

  name         = "${each.key}-${var.app_id}-app"
  organization = var.tf_org
  project_id   = var.projects == true ? tfe_project.project[0].id : null
  tag_names    = [var.app_id, each.key]

  vcs_repo {
    identifier     = "${var.gh_org}/${var.app_id}-app"
    branch         = each.key
    oauth_token_id = data.tfe_oauth_client.client.oauth_token_id
  }
}