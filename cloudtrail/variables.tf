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
  default = true
}
variable "is_multi_region_trail" {
  default = true
}
