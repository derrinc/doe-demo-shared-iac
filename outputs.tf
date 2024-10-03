# Output the Artifact Registry repository URL
output "artifact_registry_repo_url" {
  value = module.artifact_registry.artifact_registry_repo_url
}

# Output the Cloud Run service URL
output "cloud_run_url" {
  value = module.cloud_run.cloud_run_url
}
