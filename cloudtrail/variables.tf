variable "bucket_name" {
  description = "the name of the cloudtrail bucket"
  type        = string
}

variable "project" {
  description = "Project name to use"
  type        = string
}

variable "environment" {
  description = "Environment to deploy on"
  type        = string
}

variable "include_global_service_events" {
  description = "Specifies whether the trail is publishing events from global services such as IAM to the log files. "
  default     = true
  type        = bool
}

variable "is_multi_region_trail" {
  description = "Specifies whether the trail is created in the current region or in all regions."
  default     = true
  type        = bool
}

