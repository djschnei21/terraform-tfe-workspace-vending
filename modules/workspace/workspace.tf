terraform {
  required_providers {
    tfe = {
      version = "~> 0.38.0"
    }
  }
}

provider "tfe" {}

variable "repo" {
  type = string
  default = ""
}

variable "app_id" {
  type = string
  default = ""
}

variable "app_envs" {
  type = list(string)
  default = []
}

resource "tfe_workspace" "workspaces" {
  for_each = var.app_envs

  name         = "app-${var.app_id}-${each.key}"
  organization = "djs-tfcb"
  tag_names    = ["Vending Machine Demo"]
}