terraform {
  required_providers {
    tfe = {
      version = "~> 0.40.0"
    }
  }
}

variable "app_id" {
  type    = string
  description = "The ID of whatever application you want to create workspaces for"
}

variable "app_envs" {
  type    = set(string)
  description = "A list of strings dictating the environment specific workspaces that will be created for your app"
}


variable "tf_org" {
  type    = string
  description = "The name of the TFC organization you want to create workspaces within (TFE_TOKEN must be valid for this org)"
}

variable "projects" {
  type    = bool
  default = false
  description = "Whether or not you want to create an app specific TFC project to nest the workspaces inside of"
}

variable "gh_org" {
  type    = string
  description = "The name of the GH org where your repos and OAuth client are configured"
}

variable "oauth_client_name" {
  type    = string
  description = "The name of the VCS Provider OAuth Client which is configured in TFC"
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
  #tag_names    = [var.app_id, each.key]

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
  #tag_names    = [var.app_id, each.key]

  vcs_repo {
    identifier     = "${var.gh_org}/${var.app_id}-app"
    branch         = each.key
    oauth_token_id = data.tfe_oauth_client.client.oauth_token_id
  }
}