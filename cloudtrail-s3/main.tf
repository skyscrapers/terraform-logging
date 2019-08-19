locals {
  bucket_name = "cloudtrail-${var.project}-${var.environment}"
}

module "cloudtrail" {
  source                        = "../cloudtrail"
  bucket_name                   = local.bucket_name
  project                       = var.project
  environment                   = var.environment
  include_global_service_events = var.include_global_service_events
  is_multi_region_trail         = var.is_multi_region_trail
}

resource "aws_s3_bucket" "bucket" {
  bucket = local.bucket_name
  acl    = "private"
  versioning {
    enabled = var.versioning_enabled
  }

  lifecycle_rule {
    id      = "expire"
    prefix  = "/"
    enabled = var.lifecycle_expire_enabled

    expiration {
      days = var.lifecycle_expire_days
    }
  }

  tags = {
    Name = local.bucket_name
  }

  policy = data.aws_iam_policy_document.s3_permissions.json
}

data "aws_iam_policy_document" "s3_permissions" {
  statement {
    effect  = "Deny"
    actions = ["s3:PutObject"]

    resources = [
      "arn:aws:s3:::${local.bucket_name}/*",
    ]
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    condition {
      test     = "StringNotEquals"
      variable = "s3:x-amz-server-side-encryption"

      values = [
        "AES256",
      ]
    }
  }

  statement {
    actions = ["s3:GetBucketAcl"]

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    resources = [
      "arn:aws:s3:::${local.bucket_name}",
    ]
  }

  statement {
    actions = ["s3:PutObject"]

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    resources = [
      "arn:aws:s3:::${local.bucket_name}/*",
    ]

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"

      values = [
        "bucket-owner-full-control",
      ]
    }
  }
}

