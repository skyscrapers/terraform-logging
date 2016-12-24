variable "bucket_name" {
  description = "the name of the cloudtrail bucket"
}
variable "allowed_bucket_dist" {
  type = "string"
  description = "the list of arns of bucket directories allowed ex:   arn:aws:s3:::ocs-cloudtrail-log/AWSLogs/1234567890/* "
}
variable "include_global_service_events" {
  default = false
}
variable "project" {
  description = "Project name to use"
}
variable "environment" {
  description = "Environment to deploy on"
}
variable "lifecycle_expire_enabled" {
  default = false
}

variable "lifecycle_expire_days" {
  default = "365"
}

variable "versioning_enabled" {
  default = false
}

variable "expired_object_delete_marker" {
  default = false
}
