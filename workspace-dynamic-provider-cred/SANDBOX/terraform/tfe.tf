# Configure the Terraform Cloud / Enterprise provider
provider "tfe" {
  hostname = "app.terraform.io"
  token    = data.aws_secretsmanager_secret_version.tfe_token_secret.secret_string
}

# Retrieve the Terraform Cloud token from AWS Secrets Manager secret
data "aws_secretsmanager_secret_version" "tfe_token_secret" {
  secret_id = "/tfc/token"
  provider  = aws.aft-mgt
}

# Retrieve the Application organization name from AWS Secrets Manager secret
data "aws_secretsmanager_secret_version" "tfe_application_org" {
  secret_id = "/tfc/app_org"
  provider  = aws.aft-mgt
}

# Retrieve the Application organization data source
data "tfe_organization" "app_org" {
  name = data.aws_secretsmanager_secret_version.tfe_application_org.secret_string
}

# Set the application workspace name
data "aws_caller_identity" "target_account_id" {}

locals {
  app_workspace_name = "${data.aws_caller_identity.target_account_id.account_id}-app-workspace"
}

# Create Application workspace in the Application org
resource "tfe_workspace" "app_workspace" {
  name         = local.app_workspace_name
  organization = data.tfe_organization.app_org.name
  tag_names    = ["app", data.aws_caller_identity.target_account_id.account_id]
}

# The following variables must be set to allow runs to authenticate to AWS.
resource "tfe_variable" "enable_aws_provider_auth" {
  workspace_id = tfe_workspace.app_workspace.id

  key      = "TFC_AWS_PROVIDER_AUTH"
  value    = "true"
  category = "env"

  description = "Enable the Workload Identity integration for AWS."
}

resource "tfe_variable" "tfc_aws_role_arn" {
  workspace_id = tfe_workspace.app_workspace.id

  key      = "TFC_AWS_RUN_ROLE_ARN"
  value    = aws_iam_role.tfc_role.arn
  category = "env"

  description = "The AWS role arn runs will use to authenticate."
}