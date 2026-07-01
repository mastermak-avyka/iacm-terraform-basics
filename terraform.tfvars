resource_name = "iacm-poc1-demo-bucket"
region        = "eu-central-1"

# AWS credentials are intentionally NOT set here.
# In Harness IACM, configure them as pipeline secrets/variables:
aws_access_key_id     = "<+secrets.getValue("aws_state_access_key")>"
aws_secret_access_key = "<+secrets.getValue("aws_state_secret_key")>"
# For local testing, set AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY
# environment variables before running Terraform.

tags = {
  Environment = "POC"
  Project     = "IACM"
  ManagedBy   = "Terraform"
}