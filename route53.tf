# retrive Hosted Zone using ID
data "aws_route53_zone" "by_id" {
  count   = (var.hosted_zone_id != null) ? 1 : 0
  zone_id = var.hosted_zone_id
}

# retrieve Hosted Zone using Domain Name
data "aws_route53_zone" "by_name" {
  count = (var.hosted_zone_id == null) ? 1 : 0
  name  = local.source_domain
}

# creating A records in Route 53 to route traffic to the website
resource "aws_route53_record" "a_record" {
  zone_id = (var.hosted_zone_id != null) ? data.aws_route53_zone.by_id[0].zone_id : data.aws_route53_zone.by_name[0].zone_id
  name    = local.source_domain
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.source.domain_name 
    zone_id                = aws_cloudfront_distribution.source.hosted_zone_id
    evaluate_target_health = false
  }
}

