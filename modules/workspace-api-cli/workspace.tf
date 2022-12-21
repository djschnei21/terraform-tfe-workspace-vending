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

data "tfe_organization" "foo" {
  name = var.tf_org
}

# resource "tfe_project" "project" {
#   organization = var.tf_org
#   name = var.app_id
# }

resource "tfe_workspace" "network_workspaces" {
  for_each = var.app_envs

  name         = "${var.app_id}-${each.key}-network"
  organization = data.tfe_organization.foo.name
  # project_id   = tfe_project.project.id
  tag_names    = [var.app_id, each.key]
}

resource "tfe_workspace" "compute_workspaces" {
  for_each = var.app_envs

  name         = "${var.app_id}-${each.key}-compute"
  organization = data.tfe_organization.foo.name
  # project_id   = tfe_project.project.id
  tag_names    = [var.app_id, each.key]
}

resource "tfe_workspace" "storage_workspaces" {
  for_each = var.app_envs

  name         = "${var.app_id}-${each.key}-storage"
  organization = data.tfe_organization.foo.name
  # project_id   = tfe_project.project.id
  tag_names    = [var.app_id, each.key]
}