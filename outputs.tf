# Update Alternate Contacts

output "aft_alternate_contacts_state_machine_arn" {
  description = "State machine ARN"
  value = aws_sfn_state_machine.aft_alternate_contacts_state.arn
}

output "aft_alternate_contacts_extract_lambda_arn" {
  description = "aft-alternate-contacts-extract Lambda ARN"
  value = aws_lambda_function.aft_alternate_contacts_extract_lambda.arn
}
output "aft_alternate_contacts_add_lambda_arn" {
  description = "aft-alternate-contacts-add Lambda ARN"
  value = aws_lambda_function.aft_alternate_contacts_add_lambda.arn
}
output "aft_alternate_contacts_validate_lambda_arn" {
  description = "aft-alternate-contacts-validate Lambda ARN"
  value = aws_lambda_function.aft_alternate_contacts_validate_lambda.arn
}
