terraform {
  backend "s3" {
    bucket                      = "terraform-state"
    key                         = "iacm/poc1/terraform.tfstate"
    region                      = "us-east-1"
    access_key                  = "test"
    secret_key                  = "test"
    
    # 1. Route traffic out of the Docker container to your host machine
    endpoint                    = "http://host.docker.internal:4566"
    
    # 2. Force path-style addressing (both arguments included to cover all TF versions)
    use_path_style              = true
    force_path_style            = true 
    
    # 3. Skip AWS validations
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
  }
}