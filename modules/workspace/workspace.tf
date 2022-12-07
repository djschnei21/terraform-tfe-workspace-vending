terraform {
  required_providers {
    tfe = {
      version = "~> 0.38.0"
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

data "tfe_oauth_client" "client" {
  organization = "djs-tfcb"
  name         = "github-test"
}

resource "tfe_workspace" "network_workspaces" {
  for_each = var.app_envs

  name         = "network-${var.app_id}-${each.key}"
  organization = "djs-tfcb"
  tag_names    = ["vending-machine-demo"]

  vcs_repo {
    identifier = "djschnei21/network-${var.app_id}"
    branch = each.key
    oauth_token_id = data.tfe_oauth_client.client.oauth_token_id
  }
}

resource "tfe_workspace" "compute_workspaces" {
  for_each = var.app_envs

  name         = "compute-${var.app_id}-${each.key}"
  organization = "djs-tfcb"
  tag_names    = ["vending-machine-demo"]

  vcs_repo {
    identifier = "djschnei21/compute-${var.app_id}"
    branch = each.key
    oauth_token_id = data.tfe_oauth_client.client.oauth_token_id
  }
}

resource "tfe_workspace" "storage_workspaces" {
  for_each = var.app_envs

  name         = "storage-${var.app_id}-${each.key}"
  organization = "djs-tfcb"
  tag_names    = ["vending-machine-demo"]

  vcs_repo {
    identifier = "djschnei21/storage-${var.app_id}"
    branch = each.key
    oauth_token_id = data.tfe_oauth_client.client.oauth_token_id
  }
}