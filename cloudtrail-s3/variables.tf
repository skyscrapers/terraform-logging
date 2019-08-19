variable "include_global_service_events" {
  description = "Specifies whether the trail is publishing events from global services such as IAM to the log files"
  default     = true
  type        = bool
}

variable "project" {
  description = "Project name to use"
  type        = string
}

variable "environment" {
  description = "Environment to deploy on"
  type        = string
}

variable "lifecycle_expire_enabled" {
  description = "if the s3 objects will expire"
  default     = false
  type        = bool
}

variable "lifecycle_expire_days" {
  default     = 365
  description = "how many days lasts the file in the bucket"
  type        = number
}

variable "versioning_enabled" {
  description = "if we want to enable versioning or not for the s3 bucket"
  default     = false
  type        = bool
}

variable "expired_object_delete_marker" {
  description = "On a versioned bucket (versioning-enabled or versioning-suspended bucket), you can add this element in the lifecycle configuration to direct Amazon S3 to delete expired object delete markers."
  default     = false
  type        = bool
}

variable "is_multi_region_trail" {
  description = "if logtrail needs to be applied to all regions or just to the current region"
  default     = true
  type        = bool
}

