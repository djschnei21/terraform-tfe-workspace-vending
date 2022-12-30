terraform {
}

variable "app_ids" {
  type    = set(string)
  default = ["001", "testapp", "CanBeAnything"]
  description = "A list of strings dictating the App names which will have workspaces created"
}

variable "app_envs" {
  type    = set(string)
  default = ["development", "uat", "production"]
  description = "A list of strings dictating the environment specific branches that will be created"
}

variable "gh_org" {
  type    = string
  default = ""
  description = "The name of the GH org where your repos will be created and your OAuth client is configured.  You don't need to pass with if 'vcs = false'"
}

variable "tf_org" {
  type    = string
  description = "The name of the TFC organization you want to create workspaces within (TFE_TOKEN must be valid for this org)"
}

variable "oauth_client_name" {
  type    = string
  default = ""
  description = "The name of the VCS Provider OAuth Client which is configured in TFC.  You don't need to pass with if 'vcs = false'"
}

variable "vcs" {
  type    = bool
  default = true
  description = "Determines whether or not repos will be created and the workspaces connected"
}

variable "projects" {
  type    = bool
  default = false
  description = "Determines whether or not projects are utilized in TFC (BETA Feature - not yet available on TFE)"
}

module "repos" {
  source   = "./modules/repo"
  for_each = var.vcs == true ? toset(var.app_ids) : []

  app_id   = each.key
  app_envs = var.app_envs
  gh_org   = var.gh_org
}

module "workspaces-vcs" {
  source   = "./modules/workspace-vcs"
  for_each = var.vcs == true ? toset(var.app_ids) : []
  depends_on = [
    module.repos
  ]

  projects          = var.projects
  app_id            = each.key
  app_envs          = var.app_envs
  gh_org            = var.gh_org
  tf_org            = var.tf_org
  oauth_client_name = var.oauth_client_name
}

module "workspaces-api" {
  source   = "./modules/workspace-api-cli"
  for_each = var.vcs == true ? toset([]) : toset(var.app_ids)

  projects = var.projects
  app_id   = each.key
  app_envs = var.app_envs
  tf_org   = var.tf_org
}

output "workspaces" {
  value = module.workspaces-vcs.workspaces
}