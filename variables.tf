variable "source_domain" {
  type        = string
  description = "Domain for the Static Website eg. old-website.com"
  validation {
    condition = (can(regex("^(([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9])\\.)*([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9])$", var.source_domain))
      && !strcontains(var.source_domain, "..")
      && !startswith(var.source_domain, "xn--")
      && !startswith(var.source_domain, "sthree-")
      && !endswith(var.source_domain, "-s3alias")
    && !endswith(var.source_domain, "--ol-s3"))
    error_message = "Provide a valid domain name. Since S3 bucket will be created with the same name, all bucket naming rules are applicable here.  Please refer https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html"
  }
}

variable "target_domain" {
  type        = string
  description = "Domain for the Static Website eg. new-website.com"
  validation {
    condition = (can(regex("^(([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9])\\.)*([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9])$", var.target_domain))
      && !strcontains(var.target_domain, "..")
      && !startswith(var.target_domain, "xn--")
      && !startswith(var.target_domain, "sthree-")
      && !endswith(var.target_domain, "-s3alias")
    && !endswith(var.target_domain, "--ol-s3"))
    error_message = "Provide a valid domain name. Since S3 bucket will be created with the same name, all bucket naming rules are applicable here.  Please refer https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html"
  }
}

variable "hosted_zone_id" {
  type        = string
  default = null
  description = "Id of the Hosted Zone in Route 53"
}

variable "tags" {
  type = map(any)
  description = "Key/Value pairs for the tags"
  default = {
    created_by = "Terraform Module cloudpediaai/website-redirect/aws"
  }
}
