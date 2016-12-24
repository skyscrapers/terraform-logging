variable "bucket_name" {
  description = "the name of the cloudtrail bucket"
}
variable "allowed_bucket_dist" {
  type = "string"
  description = "the list of arns of bucket directories allowed ex:   arn:aws:s3:::ocs-cloudtrail-log/AWSLogs/1234567890/* "
}
variable "include_global_service_events" {
  description = "Specifies whether the trail is publishing events from global services such as IAM to the log files"
  default = true
}
variable "project" {
  description = "Project name to use"
}
variable "environment" {
  description = "Environment to deploy on"
}
variable "lifecycle_expire_enabled" {
  description = "if the s3 objects will expire"
  default = false
}

variable "lifecycle_expire_days" {
  default = "365"
  description = "how many days lasts the file in the bucket"
}

variable "versioning_enabled" {
  description = "if we want to enable versioning or not for the s3 bucket"
  default = false
}

variable "expired_object_delete_marker" {
  description = "On a versioned bucket (versioning-enabled or versioning-suspended bucket), you can add this element in the lifecycle configuration to direct Amazon S3 to delete expired object delete markers."
  default = false
}
variable "is_multi_region_trail" {
  description = "if logtrail needs to be applied to all regions or just to the current region"
  default = true
}
