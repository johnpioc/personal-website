resource "aws_s3_bucket" "personal_site_content" {
  bucket = "${var.project_name}-site-content-bucket"
}

resource "aws_s3_bucket_public_access_block" "personal_site_content" {
  bucket = aws_s3_buket.personal_site_content.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
