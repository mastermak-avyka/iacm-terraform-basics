terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

locals {
  # Use the Docker bridge gateway IP and the published Floci port.
  # 172.17.0.1 is the default docker0 gateway from which any Docker
  # container (including the Harness IaCM plugin) can reach the host.
  floci_endpoint = "http://172.17.0.1:14566"
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
