variable "bucket_name" {
  description = "the name of the cloudtrail bucket"
}
variable "project" {
  description = "Project name to use"
}
variable "environment" {
  description = "Environment to deploy on"
}
variable "include_global_service_events" {
  description = "Specifies whether the trail is publishing events from global services such as IAM to the log files. "
  default = true
}
variable "is_multi_region_trail" {
  description = "Specifies whether the trail is created in the current region or in all regions."
  default = true
}
