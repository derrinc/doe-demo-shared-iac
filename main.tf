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
  repo_name = var.repo_name
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

# Call the Cloud Run module
module "cloud_run" {
  source   = "git::https://github.com/derrinc/tf-gcp-cloud-run.git"
  region   = var.region
  app_name = var.app_name
  memory   = var.memory
  cpu      = var.cpu

  depends_on = [
    module.artifact_registry,
    module.cloud_build
  ]
}

# ------------------------------
# VPC Network Definition
# ------------------------------
# **Added** to define the VPC network in the root module
resource "google_compute_network" "vpc_network" {
  name                    = "my-vpc-network"  # You can change this name as needed
  auto_create_subnetworks = true
}

# ------------------------------
# Local Mapping of Subdomains to Cloud Run Hostnames
# ------------------------------
locals {
  cname_records = {
    for subdomain in var.cname_subdomains : subdomain => "${replace(module.cloud_run.cloud_run_url, "https://", "")}."
  }
}

# ------------------------------
# Local DNS Zone Module Invocation
# ------------------------------
module "cloud_dns" {
  source = "git::https://github.com/derrinc/tf-gcp-cloud-dns.git"

  zone_name        = var.zone_name
  zone_dns_name    = var.zone_dns_name
  zone_visibility  = var.zone_visibility
  networks         = [google_compute_network.vpc_network.id]
  zone_description = var.zone_description

  cname_records = local.cname_records

  record_ttl = 300
}

# ------------------------------
# Outputs
# ------------------------------
output "cloud_run_url" {
  description = "URL of the Cloud Run service."
  value       = module.cloud_run.cloud_run_url
}

output "cloud_dns_records" {
  description = "Details of the created CNAME records."
  value       = module.cloud_dns.cname_records
}
