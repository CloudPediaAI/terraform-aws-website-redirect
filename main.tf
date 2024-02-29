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
  source_domain = lower(var.source_domain)
  target_domain = lower(var.target_domain)
  bucket_name   = local.source_domain
}

data "aws_caller_identity" "current" {}

