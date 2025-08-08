output "project_name" {
  description = "Name of the created HCP project"
  value       = tfe_project.this.name
}

output "project_id" {
  description = "ID of the created HCP project"
  value       = tfe_project.this.id
}

output "workspace_names" {
  description = "Names of all created workspaces"
  value       = [for ws in tfe_workspace.workspaces : ws.name]
}
