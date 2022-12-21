## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_tfe"></a> [tfe](#requirement\_tfe) | ~> 0.40.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_tfe"></a> [tfe](#provider\_tfe) | ~> 0.40.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [tfe_project.project](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/project) | resource |
| [tfe_workspace.app_workspaces](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace) | resource |
| [tfe_workspace.lz_workspaces](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace) | resource |
| [tfe_organization.foo](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/data-sources/organization) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_envs"></a> [app\_envs](#input\_app\_envs) | A list of strings dictating the environment specific workspaces that will be created for your app | `set(string)` | n/a | yes |
| <a name="input_app_id"></a> [app\_id](#input\_app\_id) | The ID of whatever application you want to create workspaces for | `string` | n/a | yes |
| <a name="input_projects"></a> [projects](#input\_projects) | Whether or not you want to create an app specific TFC project to nest the workspaces inside of | `bool` | `false` | no |
| <a name="input_tf_org"></a> [tf\_org](#input\_tf\_org) | The name of the TFC organization you want to create workspaces within (TFE\_TOKEN must be valid for this org) | `string` | n/a | yes |

## Outputs

No outputs.
