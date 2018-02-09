# terraform-logging
Terraform module to setup logging in AWS

##cloudtrail

This modules allows to setup cloudtrail passing an existing s3 bucket
### Variables

See the [cloudtrail/variables.tf](cloudtrail/variables.tf) file.

### Outputs
/

### Example

```
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

See the [cloudtrail-s3/variables.tf](cloudtrail-s3/variables.tf) file.

### Outputs
/

### Example

```
module "cloudtrail-s3" {
  source                   = "github.com/skyscrapers/terraform-logging/cloudtrail-s3"
  bucket_name              = "test-cloudtrail-log"
  lifecycle_expire_enabled = true
  lifecycle_expire_days    = "365"
  project                  = "${var.project}"
  environment              = "${var.environment}"
  allowed_bucket_dist      = <<EOF
  "arn:aws:s3:::"test-cloudtrail-log/AWSLogs/12345678903/*",
  "arn:aws:s3:::"test-cloudtrail-log/AWSLogs/12345678901/*",
EOF
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

### Example

```
module "cwlogs-to-es" {
  source               = "github.com/skyscrapers/terraform-logging/cwlogs-to-es"
  elasticsearch_sg_id  ="sg-224234c"
  elasticsearch_dns    = "${module.logs.endpoint}"
  environment          = "${terraform.workspace}"
  subnet_ids           = "${data.terraform_remote_state.static.private_db_subnets}"
  log_group_name       = "kubernetes"
}
```
