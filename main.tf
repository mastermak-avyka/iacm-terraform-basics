resource "aws_s3_bucket" "this" {
  bucket = var.resource_name
  tags   = var.tags
}
