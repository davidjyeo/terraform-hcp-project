# hcp-tf-project Terraform Module

This module creates a new Terraform Cloud (HCP) Project and a set of workspaces for given environments.

## Inputs

| Name             | Description                                      | Type   | Default                        |
|------------------|--------------------------------------------------|--------|--------------------------------|
| `tfe_token`      | Terraform Cloud API token                        | string | n/a                            |
| `tfe_organization` | HCP/Terraform Cloud organization name         | string | n/a                            |
| `project_name`   | Name of the Terraform Cloud project              | string | n/a                            |
| `environments`   | List of environment names to create workspaces   | list   | `["Production", "Development", "Testing"]` |

## Outputs

| Name              | Description                          |
|-------------------|--------------------------------------|
| `project_id`      | ID of the created project            |
| `workspace_names` | List of created workspace names      |

## Example Usage

```hcl
module "hcp_project" {
  source           = "./modules/hcp-tf-project"
  tfe_token        = var.tfe_token
  tfe_organization = var.tfe_organization
  project_name     = "my-app"
  environments     = ["Production", "Dev", "Test"]
}
