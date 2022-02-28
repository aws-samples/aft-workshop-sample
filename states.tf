# Update Alternate Contacts
resource "aws_sfn_state_machine" "aft_alternate_contacts_state" {
  name       = "aft-alternate-contacts"
  role_arn   = aws_iam_role.aft_alternate_contacts_state_role.arn
  definition = templatefile("${path.module}/states/alternate-contacts.asl.json", {
    data_aft_alternate_contacts_extract_lambda  = aws_lambda_function.aft_alternate_contacts_extract_lambda.arn
    data_aft_alternate_contacts_validate_lambda = aws_lambda_function.aft_alternate_contacts_validate_lambda.arn
    data_aft_alternate_contacts_add_lambda      = aws_lambda_function.aft_alternate_contacts_add_lambda.arn
  })
}
