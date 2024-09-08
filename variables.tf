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
  description = "Docker image to deploy"
}

variable "memory" {
  type        = string
  description = "Memory limit for Cloud Run service"
}

variable "cpu" {
  type        = string
  description = "CPU limit for Cloud Run service"
}

