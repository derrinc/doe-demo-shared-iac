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

output "artifact_registry_repo_url" {
  value = module.artifact_registry.artifact_registry_repo_url
}

