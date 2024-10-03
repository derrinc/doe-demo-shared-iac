project_id = "holomua-doe-demo"
region     = "us-west1"

# Cloud Run
repo_name = "demo-app-docker-repo"
app_name  = "nginx-hello-world"
# image     = "us-west1-docker.pkg.dev/holomua-doe-demo/demo-app-docker-repo/nginx-hello-world"
memory = "128Mi"
cpu    = "0.08"

# Environment Variables
env_vars = {
  PORT = "80"
}

# Cloud Build
github_owner               = "derrinc"
github_repo                = "hello-world-app"
compute_service_account_id = "projects/holomua-doe-demo/serviceAccounts/675849533921-compute@developer.gserviceaccount.com"
terraform_sa_email         = "terraform-sa@holomua-doe-demo.iam.gserviceaccount.com"

# Cloud DNS CNAME subdomains
cname_subdomains = ["dev"]
zone_name        = "private-holomua-doe-demo-zone"
zone_dns_name    = "holomua-doe-demo.internal"
zone_visibility  = "private"
zone_description = "Internal zone for Terraform testing"
