# Update Alternate Contacts

## aft-alternate-contacts-extract
resource "aws_iam_role" "aft_alternate_contacts_extract_lambda_role" {
  name               = "aft-alternate-contacts-extract-lambda-role"
  assume_role_policy = templatefile("${path.module}/iam/trust-policies/lambda.tpl", { none = "none" })
}

resource "aws_iam_role_policy_attachment" "aft_alternate_contacts_extract_lambda_role_policy_attachment" {
  count      = length(local.lambda_managed_policies)
  role       = aws_iam_role.aft_alternate_contacts_extract_lambda_role.name
  policy_arn = local.lambda_managed_policies[count.index]
}

## aft-alternate-contacts-add
resource "aws_iam_role" "aft_alternate_contacts_add_lambda_role" {
  name               = "aft-alternate-contacts-add-lambda-role"
  assume_role_policy = templatefile("${path.module}/iam/trust-policies/lambda.tpl", { none = "none" })
}

resource "aws_iam_role_policy_attachment" "aft_alternate_contacts_add_lambda_role_policy_attachment" {
  count      = length(local.lambda_managed_policies)
  role       = aws_iam_role.aft_alternate_contacts_add_lambda_role.name
  policy_arn = local.lambda_managed_policies[count.index]
}

resource "aws_iam_role_policy" "aft_alternate_contacts_add_lambda_role_policy" {
  name = "aft-alternate-contacts-add-lambda-role-policy"
  role = aws_iam_role.aft_alternate_contacts_add_lambda_role.id
  policy = templatefile("${path.module}/iam/role-policies/lambda-aft-alternate-contacts-add-lambda-role-policy.tpl", {
    data_aws_region                   = data.aws_region.aft_management_region.name
    data_aws_account_id               = data.aws_caller_identity.aft_management_id.account_id
    data_aft_request_metadata         = data.aws_ssm_parameter.aft_request_metadata_table_name.value
    data_aft_request_metadata_kms_arn = data.aws_dynamodb_table.aft_request_metadata_table.server_side_encryption[0].kms_key_arn
    data_aws_ct_mgt_account_id        = var.aws_ct_mgt_account_id
    data_aws_ct_mgt_org_id            = var.aws_ct_mgt_org_id
  })
}

## aft-alternate-contacts-validate
resource "aws_iam_role" "aft_alternate_contacts_validate_lambda_role" {
  name               = "aft-alternate-contacts-validate-lambda-role"
  assume_role_policy = templatefile("${path.module}/iam/trust-policies/lambda.tpl", { none = "none" })
}

resource "aws_iam_role_policy_attachment" "aft_alternate_contacts_validate_lambda_role_policy_attachment" {
  count      = length(local.lambda_managed_policies)
  role       = aws_iam_role.aft_alternate_contacts_validate_lambda_role.name
  policy_arn = local.lambda_managed_policies[count.index]
}


## aft-alternate-contacts-customizations
resource "aws_iam_role" "aft_alternate_contacts_state_role" {
  name               = "aft-alternate-contacts-state-role"
  assume_role_policy = templatefile("${path.module}/iam/trust-policies/states.tpl", { none = "none" })
}

resource "aws_iam_role_policy" "aft_alternate_contacts_state_role_policy" {
  name = "aft-alternate-contacts-state-role-policy"
  role = aws_iam_role.aft_alternate_contacts_state_role.id

  policy = templatefile("${path.module}/iam/role-policies/state-aft-alternate-contacts-role-policy.tpl", {
    data_aws_region                   = data.aws_region.aft_management_region.name
    data_aws_account_id               = data.aws_caller_identity.aft_management_id.account_id
  })
}
