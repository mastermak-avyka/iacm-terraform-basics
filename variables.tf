variable "resource_name" {
  description = "Name of the S3 bucket to create"
  type        = string
}

variable "region" {
  description = "AWS region where resources will be provisioned"
  type        = string
  default     = "us-east-1"
}

variable "aws_access_key_id" {
  description = "AWS access key ID for authentication. If null, the AWS provider falls back to the AWS_ACCESS_KEY_ID environment variable or the default credentials chain."
  type        = string
  sensitive   = true
  default     = null
}

variable "aws_secret_access_key" {
  description = "AWS secret access key for authentication. If null, the AWS provider falls back to the AWS_SECRET_ACCESS_KEY environment variable or the default credentials chain."
  type        = string
  sensitive   = true
  default     = null
}

variable "tags" {
  description = "A map of tags to apply to the provisioned resources"
  type        = map(string)
  default     = {}
}
