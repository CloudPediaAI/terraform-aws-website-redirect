output "bucket" {
  value = aws_s3_bucket.redirect
  description = "S3 Bucket created for the Static Website"
}

output "cloudfront" {
  value       = aws_cloudfront_distribution.source
  description = "CloudFront created for the Static Website"
}

output "source_website_url" {
  value       = "https://${local.source_domain}"
  description = "URL of the source Website"
}
