terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

locals {
  # Use the WSL host IP and the published Floci port so both local Terraform
  # and Dockerized Harness IaCM plugin can reach the local emulator.
  floci_endpoint = "http://172.30.221.193:14566"
}

provider "aws" {
  region                      = var.region
  access_key                  = "test"
  secret_key                  = "test"

  # Skip validation for local emulator
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  skip_region_validation      = true

  # Force S3 to use path-style addressing
  s3_use_path_style           = true

  # Redirect all cloud resource API destinations straight to Floci
  endpoints {
    apigateway     = local.floci_endpoint
    cloudwatch     = local.floci_endpoint
    dynamodb       = local.floci_endpoint
    iam            = local.floci_endpoint
    lambda         = local.floci_endpoint
    s3             = local.floci_endpoint
    sns            = local.floci_endpoint
    sqs            = local.floci_endpoint
  }
}
