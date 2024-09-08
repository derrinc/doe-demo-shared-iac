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

