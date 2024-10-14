# doe-demo-iac/main.tf

# ------------------------------
# Terraform Backend Configuration
# ------------------------------
terraform {
  backend "gcs" {
    bucket = "terraform-state-shared-bucket"
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

# ------------------------------
# Cloud Run Domain Mapping
# ------------------------------
resource "google_cloud_run_domain_mapping" "domain_mapping" {
  location       = var.region
  name           = var.custom_domain
  project        = var.project_id

  metadata {
    namespace = var.project_id
  }

  spec {
    route_name = var.cloud_run_service_name
  }
}
