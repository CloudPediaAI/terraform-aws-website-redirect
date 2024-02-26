terraform {
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = "~> 5.36.0"
      configuration_aliases = [aws.us-east-1, aws]
    }
  }
}

locals {
  source_domain_name = lower(var.source_domain_name)
  target_domain_name = lower(var.target_domain_name)
  bucket_name        = local.source_domain_name
  # origin_access = lower(var.s3_access_method)
}

data "aws_caller_identity" "current" {}

