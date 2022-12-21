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
| <a name="input_app_envs"></a> [app\_envs](#input\_app\_envs) | n/a | `set(string)` | <pre>[<br>  "development",<br>  "uat",<br>  "production"<br>]</pre> | no |
| <a name="input_app_ids"></a> [app\_ids](#input\_app\_ids) | n/a | `set(string)` | `[]` | no |
| <a name="input_gh_org"></a> [gh\_org](#input\_gh\_org) | n/a | `string` | `""` | no |
| <a name="input_oauth_client_name"></a> [oauth\_client\_name](#input\_oauth\_client\_name) | n/a | `string` | `""` | no |
| <a name="input_tf_org"></a> [tf\_org](#input\_tf\_org) | n/a | `string` | `""` | no |
| <a name="input_vcs"></a> [vcs](#input\_vcs) | n/a | `bool` | `true` | no |

## Outputs

No outputs.