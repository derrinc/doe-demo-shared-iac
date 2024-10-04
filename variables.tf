# doe-demo-iac/variables.tf

variable "project_id" {
  type        = string
  description = "GCP Project ID where resources will be created."
}

variable "region" {
  type        = string
  description = "The GCP region where resources will be created."
}

variable "registry_name" {
  type        = string
  description = "The name of the Artifact Registry repository."
}

# Cloud Build variables
variable "github_owner" {
  type        = string
  description = "GitHub repository owner (username or organization)."
}

variable "github_repo" {
  type        = string
  description = "The name of the GitHub repository."
}

variable "terraform_sa_email" {
  type        = string
  description = "The email of the service account to be used by Cloud Build."
}

variable "compute_service_account_id" {
  type        = string
  description = "The service account ID for Compute Engine or Cloud Run to use."
}
