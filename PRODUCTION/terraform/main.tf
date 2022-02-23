resource "aws_config_config_rule" "r" {
  name = "vpc_flow_log_guardrail"
  source {
    owner             = "AWS"
    source_identifier = "VPC_FLOW_LOGS_ENABLED"
  }
}