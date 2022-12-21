terraform {
  required_providers {
    tfe = {
      version = "~> 0.40.0"
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


variable "tf_org" {
  type = string
  default = ""
}

resource "tfe_project" "project" {
  organization = var.tf_org
  name = var.app_id
}

resource "tfe_workspace" "network_workspaces" {
  depends_on = [
    tfe_project.project
  ]
  for_each = var.app_envs

  name         = "${var.app_id}-${each.key}-network"
  organization = var.tf_org
  project_id   = tfe_project.project.id
  tag_names    = [var.app_id, each.key]
}

resource "tfe_workspace" "compute_workspaces" {
  depends_on = [
    tfe_project.project
  ]
  for_each = var.app_envs

  name         = "${var.app_id}-${each.key}-compute"
  organization = var.tf_org
  project_id   = tfe_project.project.id
  tag_names    = [var.app_id, each.key]
}

resource "tfe_workspace" "storage_workspaces" {
  depends_on = [
    tfe_project.project
  ]
  for_each = var.app_envs

  name         = "${var.app_id}-${each.key}-storage"
  organization = var.tf_org
  project_id   = tfe_project.project.id
  tag_names    = [var.app_id, each.key]
}