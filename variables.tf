variable "resource_name" {
  description = "Name of the S3 bucket to create"
  type        = string
}

variable "region" {
  description = "AWS region where resources will be provisioned"
  type        = string
  default     = "us-east-1"
}

variable "tags" {
  description = "A map of tags to apply to the provisioned resources"
  type        = map(string)
  default     = {}
}
