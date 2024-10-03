# Remote state setup
terraform {
  backend "gcs" {
    bucket = "holomua-terraform-state"
    prefix = "env" # The base directory in the bucket; Terraform automatically appends the workspace name
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
  source   = "git::https://github.com/derrinc/tf-gcp-cloud-run.git"
  region   = var.region
  app_name = var.app_name
  # image    = var.image
  memory   = var.memory
  cpu      = var.cpu

  depends_on = [
    module.artifact_registry,
    module.cloud_build
  ]
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

### DNS
# Local Mapping of Subdomains to Cloud Run Hostnames
locals {
  cname_records = {
    for subdomain in var.cname_subdomains : subdomain => replace(google_cloud_run_service.default.status[0].url, "https://", "")
  }
}
 
# Call the Cloud DNS module
module "cloud_dns" {
  source = "./modules/cloud_dns"

  zone_name        = var.zone_name
  zone_dns_name    = var.zone_dns_name
  zone_visibility  = var.zone_visibility
  networks         = [google_compute_network.vpc_network.id]
  zone_description = var.zone_description

  cname_records = local.cname_records

  record_ttl = 300
}
