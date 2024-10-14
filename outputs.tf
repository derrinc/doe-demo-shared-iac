# doe-demo-shared-iac/outputs.tf

# Output the Artifact Registry repository URL
output "artifact_registry_repo_url" {
  value = module.artifact_registry.artifact_registry_repo_url
}
