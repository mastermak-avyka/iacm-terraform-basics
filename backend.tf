terraform {
  backend "s3" {
    bucket       = "terraform-state"
    key          = "iacm/poc1/terraform.tfstate"
    region       = "us-east-1"
    access_key   = "test"
    secret_key   = "test"
    endpoint     = "http://localhost:4566"
    use_path_style = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
  }
}
