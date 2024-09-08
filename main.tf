# Remote state setup
terraform {
  backend "gcs" {
    bucket = "holomua-terraform-state"
    prefix = "env"  # The base directory in the bucket; Terraform automatically appends the workspace name
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

# Call the Artifact Registry module
module "artifact_registry" {
  source    = "git::https://github.com/derrinc/tf-gcp-artifact-registry.git"
  region    = var.region
  repo_name = var.repo_name
}

# Call the Cloud Run module
module "cloud_run" {
  source    = "git::https://github.com/derrinc/tf-gcp-cloud-run.git"
  region    = var.region
  app_name  = var.app_name
  image     = var.image
  memory    = var.memory
  cpu       = var.cpu
}

# Output the Artifact Registry repository URL
output "artifact_registry_repo_url" {
  value = module.artifact_registry.artifact_registry_repo_url
}

# Output the Cloud Run service URL
output "cloud_run_url" {
  value = module.cloud_run.cloud_run_url
}

