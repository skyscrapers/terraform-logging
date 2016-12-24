resource "aws_cloudtrail" "cloudtrail" {
  name                          = "${var.project}-${var.environment}"
  s3_bucket_name                = "${var.bucket_name}"
  include_global_service_events = "${var.include_global_service_events}"
  is_multi_region_trail         = "${var.is_multi_region_trail}"
}
