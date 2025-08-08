variable "tfe_token" {
  type        = string
  description = "HCP Terraform API token"
  sensitive   = true
}

variable "tfe_organization" {
  type        = string
  description = "Terraform Cloud (HCP) organization name"
}

variable "project_name" {
  type        = string
  description = "The name of the new HCP project"
}

variable "environments" {
  type        = list(string)
  default     = ["Production", "Development", "Testing", "Preproduction"]
  description = "Environment names for workspace creation"
}

variable "workspace_tags" {
  type        = list(string)
  default     = []
  description = "Tags to apply to each workspace"
}

# Workspace variables
variable "workspace_variable_key" {
  type        = string
  default     = ""
  description = "Environment variable key to set in all workspaces (leave empty to skip)"
}

variable "workspace_variable_value" {
  type        = string
  default     = ""
  description = "Environment variable value"
  sensitive   = true
}

variable "workspace_variable_sensitive" {
  type        = bool
  default     = true
  description = "Whether the workspace variable is sensitive"
}

#Run triggers
variable "run_triggers" {
  description = <<EOT
List of maps defining run triggers.
Each item must contain `source` and `destination` workspace names (matching environment names).
Example:
[
  { source = "Development", destination = "Testing" },
  { source = "Testing", destination = "Production" }
]
EOT

  type    = list(object({ source = string, destination = string }))
  default = []
}
