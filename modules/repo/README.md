## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_github"></a> [github](#requirement\_github) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_github"></a> [github](#provider\_github) | ~> 5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [github_branch.app_auto_repo](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch) | resource |
| [github_branch.base_auto_repo](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch) | resource |
| [github_repository.app_auto_repo](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository) | resource |
| [github_repository.base_auto_repo](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_envs"></a> [app\_envs](#input\_app\_envs) | n/a | `set(string)` | `[]` | no |
| <a name="input_app_id"></a> [app\_id](#input\_app\_id) | n/a | `string` | `""` | no |
| <a name="input_gh_org"></a> [gh\_org](#input\_gh\_org) | n/a | `string` | `""` | no |

## Outputs

No outputs.
