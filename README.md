## Requirements

No requirements.

## Providers

No providers.

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
