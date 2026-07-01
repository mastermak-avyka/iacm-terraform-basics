terraform {
  backend "s3" {
    bucket     = "iacm-poc1-terraform-state"
    key        = "iacm/poc1/terraform.tfstate"
    region     = "us-east-1"
    access_key = "AKIARRGVETA7P4JSJPQ6"
    secret_key = "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"

    # WARNING: Hard-coding long-lived AWS credentials is NOT recommended for
    # production. In Harness IACM, configure AWS authentication via Harness
    # Secrets or OIDC instead.

    # Enable state locking with DynamoDB (optional but recommended).
    # dynamodb_table = "terraform-locks-us-east-1"

    # Server-side encryption for state at rest.
    encrypt = true
  }
}