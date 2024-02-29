# S3 bucket for redirecting 
resource "aws_s3_bucket" "redirect" {
  bucket = local.bucket_name
  tags   = var.tags
}

resource "aws_s3_bucket_ownership_controls" "redirect" {
  bucket = aws_s3_bucket.redirect.id
  rule {
    object_ownership = "ObjectWriter"
  }
}

resource "aws_s3_bucket_policy" "redirect" {
  bucket     = aws_s3_bucket.redirect.id
  policy = data.aws_iam_policy_document.cdn_access.json
  depends_on = [aws_s3_bucket_ownership_controls.redirect]
}

resource "aws_s3_bucket_website_configuration" "redirect" {
  bucket = aws_s3_bucket.redirect.id
  redirect_all_requests_to {
    host_name = local.target_domain
  }
}
