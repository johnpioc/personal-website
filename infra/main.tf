# S3 Bucket for Site Content
resource "aws_s3_bucket" "site" {
  bucket = "${var.project_name}-site-content-bucket"
}

# S3 Bucket Policy
resource "aws_s3_bucket_public_access_block" "site" {
  bucket = aws_s3_bucket.site.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Upload Site Contents to S3
locals {
  mime_types = {
    ".html" = "text/html"
    ".css"  = "text/css"
  }
}

resource "aws_s3_object" "site_files" {
  for_each = fileset("../src", "**/*")

  bucket       = aws_s3_bucket.site.id
  key          = each.value
  source       = "../site/${each.value}"
  content_type = lookup(local.mime_types, regex("\\.[^.]+$", each.value), "application/octet-stream")
  etag         = filemd5("../${each.value}")
}
