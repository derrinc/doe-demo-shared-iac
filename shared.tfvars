project_id = "holomua-doe-demo"
region     = "us-west1"

# Cloud Build
github_owner               = "derrinc"
github_repo                = "hello-world-app"
compute_service_account_id = "projects/holomua-doe-demo/serviceAccounts/675849533921-compute@developer.gserviceaccount.com"
terraform_sa_email         = "terraform-sa@holomua-doe-demo.iam.gserviceaccount.com"

# Artifactory Registry
registry_name = "doe-demo-container-registry"

# Cloud Run custom domains
custom_domain          = "holomuatech.online"
cloud_run_service_name = "doe-demo-hello-world"
