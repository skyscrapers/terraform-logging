data "aws_subnet" "selected" {
  id = "${var.subnet_ids[0]}"
}

resource "aws_security_group" "lambda" {
  name        = "lambda_cwlogs_to_elasticsearch_${var.environment}"
  description = "Lambda sg for cwlogs to elasticsearch"
  vpc_id      = "${data.aws_subnet.selected.vpc_id}"

  tags {
    Name = "lambda_cwlogs_to_elasticsearch_${var.environment}"
    Environment = "${var.environment}"
  }
}

resource "aws_security_group_rule" "lambda_to_es" {
  type            = "egress"
  from_port       = 443
  to_port         = 443
  protocol        = "tcp"
  source_security_group_id = "${var.elasticsearch_sg_id}"

  security_group_id = "${aws_security_group.lambda.id}" 
}

resource "aws_security_group_rule" "es_from_lambda" {
  type            = "ingress"
  from_port       = 443
  to_port         = 443
  protocol        = "tcp"
  source_security_group_id = "${aws_security_group.lambda.id}" 
  
  security_group_id = "${var.elasticsearch_sg_id}"
}
