variable "elasticsearch_sg_id" {
  description = "Security group ID of the AWS elasticsearch service"
  type        = string
}

variable "elasticsearch_dns" {
  description = "Elasticsearch DNS hostname"
  type        = string
}

variable "environment" {
  description = "The name of the environment these subnets belong to (prod,stag,dev)"
  type        = string
}

variable "subnet_ids" {
  description = "Subnet IDs you want to deploy the lambda in"
  type        = list(string)
}

variable "log_group_name" {
  description = "Cloudwatch logs loggroup name to use"
  type        = string
}

variable "aws_account_id" {
  description = "Your AWS account ID. Default to your current AWS account"
  default     = null
  type        = string
}

variable "aws_region" {
  description = "AWS region where you have your AWS cloudwtach loggroup deployed in. Defaults to your current region"
  default     = null
  type        = string
}

variable "index_prefix" {
  default = "cwl"
  type    = string
}

variable "retention_in_days" {
  default = 30
  type    = number
}

