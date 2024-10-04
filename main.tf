# doe-demo-iac/main.tf

# ------------------------------
# Terraform Backend Configuration
# ------------------------------
terraform {
  backend "gcs" {
    bucket = "holomua-terraform-state"
    prefix = "env" # The base directory in the bucket; Terraform automatically appends the workspace name
  }
}

# ------------------------------
# Provider Configuration
# ------------------------------
provider "google" {
  project = var.project_id
  region  = var.region
}

# ------------------------------
# External Modules Invocation
# ------------------------------

# Call the Artifact Registry module
module "artifact_registry" {
  source    = "git::https://github.com/derrinc/tf-gcp-artifact-registry.git"
  region    = var.region
  repo_name = var.registry_name
}

# Call the Cloud Build module
module "cloud_build" {
  source                     = "git::https://github.com/derrinc/tf-gcp-cloud-build.git"
  project_id                 = var.project_id
  region                     = var.region
  github_owner               = var.github_owner
  github_repo                = var.github_repo
  terraform_sa_email         = var.terraform_sa_email
  compute_service_account_id = var.compute_service_account_id
}
