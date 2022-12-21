terraform {
  required_providers {
    tfe = {
      version = "~> 0.40.0"
    }
  }
}

variable "vcs" {
  type = bool
  default = true
}

variable "repo" {
  type = string
  default = ""
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

variable "tf_org" {
  type = string
  default = ""
}

variable "oauth_client_name" {
  type = string
  default = ""
}

data "tfe_oauth_client" "client" {
  count = var.vcs == true ? 1 : 0 
  organization = var.tf_org
  name         = var.oauth_client_name
}

resource "tfe_project" "project" {
  organization = var.tf_org
  name = var.app_id
}

resource "tfe_workspace" "network_workspaces" {
  for_each = var.app_envs

  name         = "${var.app_id}-${each.key}-network"
  organization = var.tf_org
  project_id   = tfe_project.project.id
  tag_names    = [var.app_id, each.key]

  vcs_repo {
    identifier = var.vcs == true ? "${var.gh_org}/network-${var.app_id}" : null
    branch = var.vcs == true ? each.key : null
    oauth_token_id = var.vcs == true ? data.tfe_oauth_client.client.oauth_token_id : null
  }
}

resource "tfe_workspace" "compute_workspaces" {
  for_each = var.app_envs

  name         = "${var.app_id}-${each.key}-compute"
  organization = var.tf_org
  project_id   = tfe_project.project.id
  tag_names    = [var.app_id, each.key]

  vcs_repo {
    identifier = var.vcs == true ? "${var.gh_org}/compute-${var.app_id}" : null
    branch = var.vcs == true ? each.key : null
    oauth_token_id = var.vcs == true ? data.tfe_oauth_client.client.oauth_token_id : null
  }
}

resource "tfe_workspace" "storage_workspaces" {
  for_each = var.app_envs

  name         = "${var.app_id}-${each.key}-storage"
  organization = var.tf_org
  project_id   = tfe_project.project.id
  tag_names    = [var.app_id, each.key]

  vcs_repo {
    identifier = var.vcs == true ? "${var.gh_org}/storage-${var.app_id}" : null
    branch = var.vcs == true ? each.key : null
    oauth_token_id = var.vcs == true ? data.tfe_oauth_client.client.oauth_token_id : null
  }
}