# Update Alternate Contacts
## Lambda functions

resource "aws_lambda_function" "aft_alternate_contacts_extract_lambda" {
  filename         = data.archive_file.aft_alternate_contacts_extract.output_path
  function_name    = "aft-alternate-contacts-extract"
  description      = "AFT account provisioning - Alternate Contacts - Extract"
  role             = aws_iam_role.aft_alternate_contacts_extract_lambda_role.arn
  handler          = "extract-alternate-contacts.lambda_handler"
  source_code_hash = data.archive_file.aft_alternate_contacts_extract.output_base64sha256
  runtime          = "python3.9"
  timeout          = 30
  tracing_config {
    mode = "Active"
  }
  reserved_concurrent_executions = 1
}

resource "aws_cloudwatch_log_group" "aft_alternate_contacts_extract_lambda_log" {
  name              = "/aws/lambda/${aws_lambda_function.aft_alternate_contacts_extract_lambda.function_name}"
  retention_in_days = var.cloudwatch_log_group_retention
}

resource "aws_lambda_function" "aft_alternate_contacts_add_lambda" {
  filename         = data.archive_file.aft_alternate_contacts_add.output_path
  function_name    = "aft-alternate-contacts-add"
  description      = "AFT account provisioning - Alternate Contacts - Add"
  role             = aws_iam_role.aft_alternate_contacts_add_lambda_role.arn
  handler          = "add-alternate-contacts.lambda_handler"
  source_code_hash = data.archive_file.aft_alternate_contacts_add.output_base64sha256
  runtime          = "python3.9"
  timeout          = 30
  tracing_config {
    mode = "Active"
  }
  reserved_concurrent_executions = 1
}

resource "aws_cloudwatch_log_group" "aft_alternate_contacts_add_lambda_log" {
  name              = "/aws/lambda/${aws_lambda_function.aft_alternate_contacts_add_lambda.function_name}"
  retention_in_days = var.cloudwatch_log_group_retention
}

resource "aws_lambda_function" "aft_alternate_contacts_validate_lambda" {
  filename         = data.archive_file.aft_alternate_contacts_validate.output_path
  function_name    = "aft-alternate-contacts-validate"
  description      = "AFT account provisioning - Alternate Contacts - Validate"
  role             = aws_iam_role.aft_alternate_contacts_validate_lambda_role.arn
  handler          = "validate-alternate-contacts.lambda_handler"
  source_code_hash = data.archive_file.aft_alternate_contacts_validate.output_base64sha256
  runtime          = "python3.9"
  timeout          = 30
  tracing_config {
    mode = "Active"
  }
  reserved_concurrent_executions = 1
}

resource "aws_cloudwatch_log_group" "aft_alternate_contacts_validate_lambda_log" {
  name              = "/aws/lambda/${aws_lambda_function.aft_alternate_contacts_validate_lambda.function_name}"
  retention_in_days = var.cloudwatch_log_group_retention
}