resource_name = "iacm-poc1-demo-bucket"
region        = "eu-central-1"

aws_access_key_id     = "<+secrets.getValue(\"aws_state_access_key\")>"
aws_secret_access_key = "<+secrets.getValue(\"aws_state_secret_key\")>"

tags = {
  Environment = "POC"
  Project     = "IACM"
  ManagedBy   = "Terraform"
}
