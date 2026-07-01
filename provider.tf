terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region     = var.region
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key

  # WARNING: Hard-coding credentials is acceptable for this POC but is NOT a
  # production best practice. In Harness IACM, store these in Harness Secrets
  # Manager or use OIDC-based AWS authentication instead.
}
