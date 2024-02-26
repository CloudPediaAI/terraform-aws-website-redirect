output "bucket" {
  value = aws_s3_bucket.web_portal_redirect
  description = "S3 Bucket created for the Static Website"
}

output "cloudfront" {
  value       = aws_cloudfront_distribution.public
  description = "CloudFront created for the Static Website"
}

output "source_website_url" {
  value       = "https://${local.source_domain_name}"
  description = "URL of the source Website"
}
