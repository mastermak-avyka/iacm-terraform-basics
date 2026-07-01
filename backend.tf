terraform {
  backend "s3" {
    bucket = "iacm-poc1-terraform-state"
    key    = "iacm/poc1/terraform.tfstate"
    region = "us-east-1"

    # NOTE: AWS credentials for the backend are intentionally NOT hard-coded
    # here. In Harness IACM, supply them in the pipeline's
    # "Backend Configuration" section using Harness secret expressions:
    #
    #   access_key = <+secrets.getValue("aws_state_access_key")>
    #   secret_key = <+secrets.getValue("aws_state_secret_key")>
    #
    # For local testing only, you can set AWS_ACCESS_KEY_ID and
    # AWS_SECRET_ACCESS_KEY environment variables or run the Floci local
    # backend described in README.md.

    # Enable state locking with DynamoDB (optional but recommended).
    # dynamodb_table = "iacm-poc1-terraform-locks"

    # Server-side encryption for state at rest.
    encrypt = true
  }
}
