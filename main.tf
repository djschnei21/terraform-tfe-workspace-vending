terraform {
}

variable "app_ids" {
    type = set(string)
    default = []
}

variable "app_envs" {
  type = set(string)
  default = ["development", "uat", "production"]
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

variable "vcs" {
  type = bool
  default = true
}

module "repos" {
    source = "./modules/repo"
    count = var.vcs == true ? 1 : 0 

    for_each = toset(var.app_ids)
    app_id = each.key
    app_envs = var.app_envs
    gh_org = var.gh_org
}

module "workspaces" {
    source = "./modules/workspace"

    vcs = var.vcs
    for_each = var.app_ids
    app_id = each.key
    app_envs = var.app_envs
    gh_org = var.gh_org
    tf_org = var.tf_org
    oauth_client_name = var.oauth_client_name
}