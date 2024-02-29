data "aws_iam_policy_document" "cdn_access" {

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
      "${aws_s3_bucket.redirect.arn}/*"
    ]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [format("arn:aws:cloudfront::%s:distribution/%s", data.aws_caller_identity.current.account_id, aws_cloudfront_distribution.source.id)]
    }
  }
}
