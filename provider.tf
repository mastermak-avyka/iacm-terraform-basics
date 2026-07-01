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

  # NOTE: If the variables above are null, the AWS provider automatically uses
  # the AWS_ACCESS_KEY_ID / AWS_SECRET_ACCESS_KEY environment variables or the
  # default AWS credentials chain. In Harness IACM, set these as pipeline
  # variables pointing to Harness secrets:
  #
  #   aws_access_key_id     = <+secrets.getValue("aws_state_access_key")>
  #   aws_secret_access_key = <+secrets.getValue("aws_state_secret_key")>
  #
  # For production, prefer OIDC-based AWS authentication over long-lived keys.
}
