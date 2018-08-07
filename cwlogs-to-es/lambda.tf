data "template_file" "node" {
  template = "${file("${path.module}/lambda/index.js")}"

  vars {
    elasticsearch_dns = "${var.elasticsearch_dns}"
    index_prefix      = "${var.index_prefix}"
  }
}

data "archive_file" "zip" {
  type                    = "zip"
  source_content          = "${data.template_file.node.rendered}"
  source_content_filename = "index.js"
  output_path             = "cw_logs_es.zip"
}

resource "aws_lambda_function" "lambda" {
  function_name = "lambda_cwlogs_to_elasticsearch_${var.environment}"
  description   = "Lambda function to ship AWS Cloudwatch logs to Elasticsearch for ${var.environment}"

  filename         = "${data.archive_file.zip.output_path}"
  source_code_hash = "${data.archive_file.zip.output_base64sha256}"

  role    = "${aws_iam_role.iam_for_lambda.arn}"
  handler = "index.handler"
  runtime = "nodejs8.10"
  timeout = "60"

  vpc_config {
    subnet_ids         = ["${var.subnet_ids}"]
    security_group_ids = ["${aws_security_group.lambda.id}"]
  }
}

data "aws_region" "current" {
  current = true
}

data "aws_caller_identity" "current" {}

locals {
  aws_region     = "${var.aws_region != "" ? var.aws_region : data.aws_region.current.name}"
  aws_account_id = "${var.aws_account_id != "" ? var.aws_account_id : data.aws_caller_identity.current.account_id}"
}

resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id  = "AllowExecutionFromCloudWatch${var.environment}"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.lambda.function_name}"
  principal     = "logs.amazonaws.com"
  source_arn    = "arn:aws:logs:${local.aws_region}:${local.aws_account_id}:log-group:${var.log_group_name}:*"
}
