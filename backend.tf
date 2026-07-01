terraform {
  backend "s3" {
    bucket                      = "terraform-state"
    key                         = "iacm/poc1/terraform.tfstate"
    region                      = "us-east-1"
    access_key                  = "test"
    secret_key                  = "test"
    
    # 1. Route traffic out of the Docker container via the docker0 gateway
    endpoint                    = "http://172.17.0.1:14566"
    
    # 2. Force path-style addressing (required by Terraform <= 1.5.x / Harness IaCM)
    force_path_style            = true
    
    # 3. Skip AWS validations
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
  }
}