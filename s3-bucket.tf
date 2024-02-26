# S3 bucket for redirecting 
resource "aws_s3_bucket" "web_portal_redirect" {
  bucket = local.bucket_name
  tags   = var.tags
}

resource "aws_s3_bucket_ownership_controls" "web_portal_redirect_acl_ownership" {
  bucket = aws_s3_bucket.web_portal_redirect.id
  rule {
    object_ownership = "ObjectWriter"
  }
}

resource "aws_s3_bucket_policy" "web_portal_redirect_policy" {
  bucket     = aws_s3_bucket.web_portal_redirect.id
  policy = data.aws_iam_policy_document.access_public.json
  depends_on = [aws_s3_bucket_ownership_controls.web_portal_redirect_acl_ownership]
}

resource "aws_s3_bucket_website_configuration" "web_portal_redirect_config" {
  bucket = aws_s3_bucket.web_portal_redirect.id
  redirect_all_requests_to {
    host_name = local.target_domain_name
  }
}
