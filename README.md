## Requirements

This module has two modes; one which provision VCS backed workspaces and repos in GH, and another which does not provision repos and configures workspaces for CLI/API workflows.  At the very least the workspace using this module needs an environment variable set called TFE_TOKEN which is a valid user token with all required permissions for the target organization.  If you are using the VCS workflow mode, this workspace will also need a GITHUB_TOKEN environment variable set.

## VCS Example Usage

```
module "workspace-vending" {
  # source  = "app.terraform.io/djs-tfcb/workspace-vending/tfe"
  # version = "4.0.0"
  source = "github.com/djschnei21/terraform-tfe-workspace-vending"
  tf_org = "djs-tfcb"
  gh_org = "djschnei21"
  oauth_client_name = "github-test"
  vcs = true
  app_ids = [
    "100",
    "200"
  ]
  app_envs = [ "development", "uat", "production" ]
}
```

## CLI/API Example Usage

```
module "workspace-vending" {
  # source  = "app.terraform.io/djs-tfcb/workspace-vending/tfe"
  # version = "4.0.0"
  source = "github.com/djschnei21/terraform-tfe-workspace-vending"
  tf_org = "djs-tfcb"
  vcs = false
  app_ids = [
    "100",
    "200"
  ]
  app_envs = [ "development", "uat", "production" ]
}
```

## Providers

All providers determined by sub-modules

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_repos"></a> [repos](#module\_repos) | ./modules/repo | n/a |
| <a name="module_workspaces-api"></a> [workspaces-api](#module\_workspaces-api) | ./modules/workspace-api-cli | n/a |
| <a name="module_workspaces-vcs"></a> [workspaces-vcs](#module\_workspaces-vcs) | ./modules/workspace-vcs | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_envs"></a> [app\_envs](#input\_app\_envs) | A list of strings dictating the environment specific branches that will be created | `set(string)` | <pre>[<br>  "development",<br>  "uat",<br>  "production"<br>]</pre> | no |
| <a name="input_app_ids"></a> [app\_ids](#input\_app\_ids) | A list of strings dictating the App names which will have workspaces created | `set(string)` | <pre>[<br>  "001",<br>  "testapp",<br>  "CanBeAnything"<br>]</pre> | no |
| <a name="input_gh_org"></a> [gh\_org](#input\_gh\_org) | The name of the GH org where your repos will be created and your OAuth client is configured.  You don't need to pass with if 'vcs = false' | `string` | `""` | no |
| <a name="input_oauth_client_name"></a> [oauth\_client\_name](#input\_oauth\_client\_name) | The name of the VCS Provider OAuth Client which is configured in TFC.  You don't need to pass with if 'vcs = false' | `string` | `""` | no |
| <a name="input_projects"></a> [projects](#input\_projects) | Determines whether or not projects are utilized in TFC (BETA Feature - not yet available on TFE) | `bool` | `false` | no |
| <a name="input_tf_org"></a> [tf\_org](#input\_tf\_org) | The name of the TFC organization you want to create workspaces within (TFE\_TOKEN must be valid for this org) | `string` | n/a | yes |
| <a name="input_vcs"></a> [vcs](#input\_vcs) | Determines whether or not repos will be created and the workspaces connected | `bool` | `true` | no |

## Outputs

No outputs.
