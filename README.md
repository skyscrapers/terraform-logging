# terraform-logging

Terraform module to setup logging in AWS

## cloudtrail

This modules allows to setup cloudtrail passing an existing s3 bucket

### Variables

* [`bucket_name`]: String(required): the name of the cloudtrail bucket
* [`project`]: String(required): Project name to use
* [`environment`]: String(required): Environment to deploy on
* [`include_global_service_events`]: Boolean(optional): Specifies whether the trail is publishing events from global services such as IAM to the log files. (default: true)
* [`is_multi_region_trail`]: Boolean(optional): Specifies whether the trail is created in the current region or in all regions. (default: true)

### Outputs

/

### Example

```hcl
module "cloudtrail" {
  source                   = "github.com/skyscrapers/terraform-logging/cloudtrail"
  bucket_name              = "test-cloudtrail-log"
  project                  = "${var.project}"
  environment              = "${var.environment}"
}

```

## cloudtrail-s3

Terraform module to setup the cloudtrail s3 bucket and enable cloudtrail

### Variables

* [`project`]: String(required): Project name to use
* [`environment`]: String(required): Environment to deploy on
* [`lifecycle_expire_enabled`]: String(required)
* [`versioning_enabled`]: String(required)
* [`include_global_service_events`]: Boolean(optional): Specifies whether the trail is publishing events from global services such as IAM to the log files. (default: true)
* [`expired_object_delete_marker`]: String(optional) On a versioned bucket (versioning-enabled or versioning-suspended bucket), you can add this element in the lifecycle configuration to direct Amazon S3 to delete expired object delete markers. (default: false)
* [`is_multi_region_trail`]: Boolean(optional): Specifies whether the trail is created in the current region or in all regions. (default: true)

### Outputs

/

### Example

```hcl
module "cloudtrail-s3" {
  source                   = "github.com/skyscrapers/terraform-logging/cloudtrail-s3"
  lifecycle_expire_enabled = true
  lifecycle_expire_days    = "365"
  project                  = "${var.project}"
  environment              = "${var.environment}"
}
```

## cwlogs-to-es

Module to ship AWS Cloudwatch logs to AWS Elasticsearch. This assumes that your AWS Elasticsearch is running inside a VPC and your Lambda will be deployed inside that VPC. The needed IAM rights + securitygroups and rules are created. To make this work, you need to choose a subnet that has access to the AWS elasticsearch service.

### Variables

* [`elasticsearch_sg_id`]: String(required): Security group ID of the AWS elasticsearch service.
* [`elasticsearch_dns`]: String(required): Elasticsearch DNS hostname
* [`environment`]: String(required): the name of the environment these subnets belong to (prod,stag,dev)
* [`subnet_ids`]: List(required): Subnet IDs you want to deploy the lambda in
* [`log_group_name`]: String(required): Cloudwatch logs loggroup name to use
* [`aws_account_id`]: String(optional): Your AWS account ID. Default to your current AWS account
* [`aws_region`]: String(optional): AWS region where you have your AWS cloudwtach loggroup deployed in. Defaults to your current region
* [`retention_in_days`]: Int(optional): How many days the lambda logs are kept. Defaults to 30 days

### Example

```hcl
module "cwlogs-to-es" {
  source               = "github.com/skyscrapers/terraform-logging/cwlogs-to-es"
  elasticsearch_sg_id  ="sg-224234c"
  elasticsearch_dns    = "${module.logs.endpoint}"
  environment          = "${terraform.workspace}"
  subnet_ids           = "${data.terraform_remote_state.static.private_db_subnets}"
  log_group_name       = "kubernetes"
}
```
