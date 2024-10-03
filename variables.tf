# doe-demo-iac/variables.tf

variable "project_id" {
  type        = string
  description = "GCP Project ID where resources will be created."
}

variable "region" {
  type        = string
  description = "The GCP region where resources will be created."
}

variable "repo_name" {
  type        = string
  description = "The name of the Artifact Registry repository."
}

# Cloud Run variables
variable "app_name" {
  type        = string
  description = "Name of the Cloud Run application"
}

variable "image" {
  type        = string
  description = "Placeholder docker image"
  default     = "gcr.io/cloudrun/hello"
}

variable "env_vars" {
  type        = map(string)
  description = "Environment variables for the Cloud Run container"
  default     = {}
}

variable "memory" {
  type        = string
  description = "Memory limit for Cloud Run service"
}

variable "cpu" {
  type        = string
  description = "CPU limit for Cloud Run service"
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

# Google Cloud DNS variables
variable "cname_subdomains" {
  type        = list(string)
  description = "List of subdomains to create CNAME records for."
}

variable "zone_name" {
  type        = string
  description = "The name of the DNS managed zone."
}

variable "zone_dns_name" {
  type        = string
  description = "The DNS name of the managed zone, e.g., 'example.internal.'. Must end with a dot."
}

variable "zone_visibility" {
  type        = string
  description = "The visibility of the DNS managed zone. Options: 'public', 'private'."
  default     = "private"
}

variable "zone_description" {
  type        = string
  description = "A description for the DNS managed zone."
  default     = "Managed by Terraform"
}
