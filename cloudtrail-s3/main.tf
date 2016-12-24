resource "aws_cloudtrail" "cloudtrail" {
    name = "${var.project}-${var.environment}"
    s3_bucket_name = "${var.bucket_name}"
    s3_key_prefix = "prefix"
    include_global_service_events = true
}

resource "aws_s3_bucket" "bucket" {
    bucket = "${var.bucket_name}"
    acl    = "private"

    versioning {
      enabled = "${var.versioning_enabled}"
    }

    lifecycle_rule {
      id      = "expire"
      prefix  = "/"
      enabled = "${var.lifecycle_expire_enabled}"

      expiration {
        days = "${var.lifecycle_expire_days}"
      }
    }

    tags {
      Name = "${var.bucket_name}"
    }
    policy = <<POLICY
{
	"Version": "2012-10-17",
	"Id": "PutObjPolicy",
	"Statement": [
		{
			"Sid": "DenyIncorrectEncryptionHeader",
			"Effect": "Deny",
			"Principal": "*",
			"Action": "s3:PutObject",
			"Resource": "arn:aws:s3:::${var.bucket_name}/*",
			"Condition": {
				"StringNotEquals": {
					"s3:x-amz-server-side-encryption": "AES256"
				}
			}
		},
		{
			"Sid": "DenyUnEncryptedObjectUploads",
			"Effect": "Deny",
			"Principal": "*",
			"Action": "s3:PutObject",
			"Resource": "arn:aws:s3:::${var.bucket_name}/*",
			"Condition": {
				"Null": {
					"s3:x-amz-server-side-encryption": "true"
				}
			}
		},
		{
			"Sid": "AWSCloudTrailAclCheck20131101",
			"Effect": "Allow",
			"Principal": {
				"AWS": [
					"arn:aws:iam::113285607260:root",
					"arn:aws:iam::859597730677:root",
					"arn:aws:iam::977081816279:root",
					"arn:aws:iam::216624486486:root",
					"arn:aws:iam::086441151436:root",
					"arn:aws:iam::388731089494:root",
					"arn:aws:iam::035351147821:root",
					"arn:aws:iam::492519147666:root",
					"arn:aws:iam::284668455005:root",
					"arn:aws:iam::814480443879:root",
					"arn:aws:iam::903692715234:root"
				]
			},
			"Action": "s3:GetBucketAcl",
			"Resource": "arn:aws:s3:::${var.bucket_name}"
		},
		{
			"Sid": "AWSCloudTrailWrite20131101",
			"Effect": "Allow",
			"Principal": {
				"AWS": [
					"arn:aws:iam::113285607260:root",
					"arn:aws:iam::859597730677:root",
					"arn:aws:iam::977081816279:root",
					"arn:aws:iam::216624486486:root",
					"arn:aws:iam::086441151436:root",
					"arn:aws:iam::388731089494:root",
					"arn:aws:iam::035351147821:root",
					"arn:aws:iam::492519147666:root",
					"arn:aws:iam::284668455005:root",
					"arn:aws:iam::814480443879:root",
					"arn:aws:iam::903692715234:root"
				]
			},
			"Action": "s3:PutObject",
			"Resource": [
        ${var.allowed_bucket_dist}
			],
			"Condition": {
				"StringEquals": {
					"s3:x-amz-acl": "bucket-owner-full-control"
				}
			}
		},
		{
			"Sid": "AWSCloudTrailAclCheck20150319",
			"Effect": "Allow",
			"Principal": {
				"Service": "cloudtrail.amazonaws.com"
			},
			"Action": "s3:GetBucketAcl",
			"Resource": "arn:aws:s3:::${var.bucket_name}"
		},
		{
			"Sid": "AWSCloudTrailWrite20150319",
			"Effect": "Allow",
			"Principal": {
				"Service": "cloudtrail.amazonaws.com"
			},
			"Action": "s3:PutObject",
			"Resource": "arn:aws:s3:::${var.bucket_name}/*",
			"Condition": {
				"StringEquals": {
					"s3:x-amz-acl": "bucket-owner-full-control"
				}
			}
		}
	]
}
POLICY
}
