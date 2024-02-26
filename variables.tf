variable "source_domain_name" {
  type        = string
  description = "Domain for the Static Website eg. old-website.com"
  validation {
    condition = (can(regex("^(([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9])\\.)*([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9])$", var.source_domain_name))
      && !strcontains(var.source_domain_name, "..")
      && !startswith(var.source_domain_name, "xn--")
      && !startswith(var.source_domain_name, "sthree-")
      && !endswith(var.source_domain_name, "-s3alias")
    && !endswith(var.source_domain_name, "--ol-s3"))
    error_message = "Provide a valid domain name. Since S3 bucket will be created with the same name, all bucket naming rules are applicable here.  Please refer https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html"
  }
}

variable "target_domain_name" {
  type        = string
  description = "Domain for the Static Website eg. new-website.com"
  validation {
    condition = (can(regex("^(([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9])\\.)*([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9])$", var.target_domain_name))
      && !strcontains(var.target_domain_name, "..")
      && !startswith(var.target_domain_name, "xn--")
      && !startswith(var.target_domain_name, "sthree-")
      && !endswith(var.target_domain_name, "-s3alias")
    && !endswith(var.target_domain_name, "--ol-s3"))
    error_message = "Provide a valid domain name. Since S3 bucket will be created with the same name, all bucket naming rules are applicable here.  Please refer https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html"
  }
}

variable "hosted_zone_id" {
  type        = string
  default = null
  description = "Id of the Hosted Zone in Route 53"
}

variable "s3_access_method" {
  type = string
  default = "public"
  description = "Access method for S3: OAC/OAI/public"
  validation {
    condition     = contains(["oac", "oai", "public"], lower(var.s3_access_method))
    error_message = "Unsupported method <${var.s3_access_method}>. Supported values are <OAC, OAI, public>"
  }  
}

variable "tags" {
  type = map(any)
  description = "Key/Value pairs for the tags"
  default = {
    created_by = "Terraform Module cloudpediaai/website-redirect/aws"
  }
}
