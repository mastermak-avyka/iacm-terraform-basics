# IACM POC1 — Terraform AWS S3 Bucket

This Terraform configuration provisions a single AWS S3 bucket.

## Modes

### 1. Real AWS (default — used by Harness IACM)

By default, `provider.tf` and `backend.tf` are configured for real AWS.
State is stored in `s3://iacm-poc1-terraform-state/iacm/poc1/terraform.tfstate`.

#### Harness IACM secret configuration

1. Create two Harness secrets:
   - `aws_state_access_key`
   - `aws_state_secret_key`

2. In the IACM pipeline **Backend Configuration** section, set:

   ```text
   access_key = <+secrets.getValue("aws_state_access_key")>
   secret_key = <+secrets.getValue("aws_state_secret_key")>
   ```

3. In the IACM pipeline **Variables** section, set:

   ```text
   aws_access_key_id     = <+secrets.getValue("aws_state_access_key")>
   aws_secret_access_key = <+secrets.getValue("aws_state_secret_key")>
   ```

   These variables are passed to the AWS provider in `provider.tf`.

### 2. Local Floci emulator (for local testing only)

To test locally against Floci:

1. Start Floci:

   ```bash
   docker run -d --name floci \
     -p 0.0.0.0:14566:4566 \
     -e FLOCI_DEFAULT_REGION=us-east-1 \
     floci/floci:latest
   ```

2. Create the state bucket in Floci:

   ```bash
   aws --endpoint-url=http://172.17.0.1:14566 s3 mb s3://terraform-state
   ```

3. Replace `provider.tf` and `backend.tf` with the Floci versions below, or set
   environment variables:

   ```bash
   export AWS_ENDPOINT_URL=http://172.17.0.1:14566
   export AWS_DEFAULT_REGION=us-east-1
   export AWS_ACCESS_KEY_ID=test
   export AWS_SECRET_ACCESS_KEY=test
   ```

### Local Floci `provider.tf` template

```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region                      = var.region
  access_key                  = "test"
  secret_key                  = "test"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  skip_region_validation      = true
  s3_use_path_style           = true

  endpoints {
    apigateway = "http://172.17.0.1:14566"
    cloudwatch = "http://172.17.0.1:14566"
    dynamodb   = "http://172.17.0.1:14566"
    iam        = "http://172.17.0.1:14566"
    lambda     = "http://172.17.0.1:14566"
    s3         = "http://172.17.0.1:14566"
    sns        = "http://172.17.0.1:14566"
    sqs        = "http://172.17.0.1:14566"
  }
}
```

### Local Floci `backend.tf` template

```hcl
terraform {
  backend "s3" {
    bucket                      = "terraform-state"
    key                         = "iacm/poc1/terraform.tfstate"
    region                      = "us-east-1"
    access_key                  = "test"
    secret_key                  = "test"
    endpoint                    = "http://172.17.0.1:14566"
    force_path_style            = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
  }
}
```

## Security Notice

Hard-coding AWS credentials in `terraform.tfvars` and `backend.tf` is done here
for POC simplicity. For production usage in Harness IACM, migrate to:

- Harness Secrets Manager for access/secret keys, or
- OIDC-based AWS authentication (recommended).
