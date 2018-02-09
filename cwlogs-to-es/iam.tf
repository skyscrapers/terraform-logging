data "aws_iam_policy_document" "policy" {
  statement {
    sid    = ""
    effect = "Allow"

    principals {
      identifiers = ["lambda.amazonaws.com"]
      type        = "Service"
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = "lambda_cwlogs_to_elasticsearch_${var.environment}"
  assume_role_policy = "${data.aws_iam_policy_document.policy.json}"
}

resource "aws_iam_role_policy_attachment" "vpc-execution" {
    role       = "${aws_iam_role.iam_for_lambda.name}"
    policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}

resource "aws_iam_role_policy" "cwlogs-es" {
  name = "lambda_cwlogs_to_elasticsearch_${var.environment}"
  role = "${aws_iam_role.iam_for_lambda.id}"

  policy = "${data.aws_iam_policy_document.cwlogs-es.json}"
}

data "aws_iam_policy_document" "cwlogs-es" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]

    resources = [
      "arn:aws:logs:*:*:*",
    ]
  }

  statement {
    actions = [
      "es:ESHttpPost",
    ]

    resources = [
      "arn:aws:es:*:*:*",
    ]
  }
}
