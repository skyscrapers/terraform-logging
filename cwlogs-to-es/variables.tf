variable "elasticsearch_sg_id" {
    description = "Security group ID of the AWS elasticsearch service"
}

variable "elasticsearch_dns" {
    description = "Elasticsearch DNS hostname"
}

variable "environment" {
    description = "The name of the environment these subnets belong to (prod,stag,dev)"
}

variable "subnet_ids" {
    description = "Subnet IDs you want to deploy the lambda in"
    type = "list"
}

variable "log_group_name" {
    description = "Cloudwatch logs loggroup name to use"
}

variable "aws_account_id" {
    description = "Your AWS account ID. Default to your current AWS account"
    default = ""
}

variable "aws_region" {
    description = "AWS region where you have your AWS cloudwtach loggroup deployed in. Defaults to your current region"
    default = ""
}
