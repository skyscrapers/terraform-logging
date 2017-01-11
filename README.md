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
