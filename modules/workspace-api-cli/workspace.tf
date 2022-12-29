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

data "tfe_organization" "foo" {
  name = var.tf_org
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
}

resource "tfe_workspace" "app_workspaces" {
  for_each = var.app_envs

  name         = "${each.key}-${var.app_id}-app"
  organization = var.tf_org
  project_id   = var.projects == true ? tfe_project.project[0].id : null
  #tag_names    = [var.app_id, each.key]
}