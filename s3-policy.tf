data "aws_iam_policy_document" "access_public" {

  statement {
    sid = "allowReqFromCloudFrontOnly"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }


    actions = [
      "s3:GetObject"
    ]

    resources = [
      "${aws_s3_bucket.web_portal_redirect.arn}/*"
    ]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [format("arn:aws:cloudfront::%s:distribution/%s", data.aws_caller_identity.current.account_id, aws_cloudfront_distribution.public.id)]
    }
  }
}
