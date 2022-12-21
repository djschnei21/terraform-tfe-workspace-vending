terraform {
  required_providers {
    tfe = {
      version = "~> 0.40.0"
    }
  }
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
    identifier = "${var.gh_org}/network-${var.app_id}"
    branch = each.key
    oauth_token_id = data.tfe_oauth_client.client[0].oauth_token_id
  }
}

resource "tfe_workspace" "compute_workspaces" {
  for_each = var.app_envs

  name         = "${var.app_id}-${each.key}-compute"
  organization = var.tf_org
  project_id   = tfe_project.project.id
  tag_names    = [var.app_id, each.key]

  vcs_repo {
    identifier = "${var.gh_org}/compute-${var.app_id}"
    branch = each.key
    oauth_token_id = data.tfe_oauth_client.client[0].oauth_token_id
  }
}

resource "tfe_workspace" "storage_workspaces" {
  for_each = var.app_envs

  name         = "${var.app_id}-${each.key}-storage"
  organization = var.tf_org
  project_id   = tfe_project.project.id
  tag_names    = [var.app_id, each.key]

  vcs_repo {
    identifier = "${var.gh_org}/storage-${var.app_id}"
    branch = each.key
    oauth_token_id = data.tfe_oauth_client.client[0].oauth_token_id
  }
}