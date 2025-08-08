# Create the HCP (TFC) project
resource "tfe_project" "this" {
  name         = var.project_name
  organization = var.tfe_organization
  description  = "Better Description Required"
}

# Create workspaces under the project
resource "tfe_workspace" "workspaces" {
  for_each       = toset(var.environments)
  name           = "${var.project_name}-${lower(each.key)}"
  organization   = var.tfe_organization
  project_id     = tfe_project.this.id
  queue_all_runs = true
  description    = "Better Description Required"

  # # Optional: settings to configure workspace
  # execution_mode    = "remote" # or "local" / "agent" / "custom"
  # working_directory = "./"

  # # You can optionally assign a VCS repo here
  # # vcs_repo {
  # #   identifier = "org/repo"
  # #   branch     = "main"
  # #   oauth_token_id = "ot-XXXXXX"
  # # }
}

# // Create a team for the workspace
# resource "tfe_team" "this" {
#   for_each     = toset(var.environments)
#   name         = "${var.project_name}-${lower(each.key)}-run-team"
#   organization = var.tfe_organization
# }

# // Create a team access for the workspace
# resource "tfe_team_access" "this" {
#   for_each     = toset(var.environments)
#   access       = "write"
#   team_id      = tfe_team.this[each.key].id
#   workspace_id = tfe_workspace.this[each.key].id
# }

# ephemeral "tfe_team_token" "this" {
#   for_each = toset(var.environments)
#   team_id  = tfe_team.this[each.key].id
# }

resource "tfe_variable_set" "project" {
  name         = "${tfe_project.this.name}-proj-vset"
  description  = "Better Description Required"
  organization = tfe_project.this.organization
  priority     = true
}

resource "tfe_project_variable_set" "project" {
  variable_set_id = tfe_variable_set.project.id
  project_id      = tfe_project.this.id
}

// Create a variable for the Azure Provider Auth
resource "tfe_variable" "tfc_azure_provider_auth" {
  key             = "TFC_AZURE_PROVIDER_AUTH"
  value           = "true"
  category        = "env"
  variable_set_id = tfe_variable_set.project.id
}

# # Add workspace variables
# resource "tfe_variable" "workspace_variables" {
#   for_each = {
#     for env in var.environments :
#     "${env}" => env
#   }

#   key          = var.workspace_variable_key
#   value        = var.workspace_variable_value
#   category     = "env"
#   workspace_id = tfe_workspace.workspaces[each.key].id
#   sensitive    = var.workspace_variable_sensitive
# }
