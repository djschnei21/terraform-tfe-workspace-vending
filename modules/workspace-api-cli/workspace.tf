terraform {
  required_providers {
    tfe = {
      version = "~> 0.40.0"
    }
  }
}
variable "app_id" {
  type    = string
}

variable "app_envs" {
  type    = set(string)
}


variable "tf_org" {
  type    = string
}

data "tfe_organization" "foo" {
  name = var.tf_org
}

variable "projects" {
  type    = bool
  default = false
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
}

resource "tfe_workspace" "app_workspaces" {
  for_each = var.app_envs

  name         = "${each.key}-${var.app_id}-app"
  organization = var.tf_org
  project_id   = var.projects == true ? tfe_project.project[0].id : null
  tag_names    = [var.app_id, each.key]
}