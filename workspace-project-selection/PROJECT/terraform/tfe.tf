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

# Retrieve the organization name from parameter store
data "aws_ssm_parameter" "app_org" {
  name = "/aft/account-request/custom-fields/app_org"
}

# Retrieve the project name from parameter store
data "aws_ssm_parameter" "app_project" {
  name = "/aft/account-request/custom-fields/app_project"
}

# Retrieve the workspace name from parameter store
data "aws_ssm_parameter" "app_workspace" {
  name = "/aft/account-request/custom-fields/app_workspace"
}

# Verify the organization data source
data "tfe_organization" "app_org" {
  name = data.aws_ssm_parameter.app_org.value
}

# Verify the project id from data source
data "tfe_project" "app_project" {
  name         = data.aws_ssm_parameter.app_project.value
  organization = data.tfe_organization.app_org.name
}

# Create Application workspace in the target org and project name
resource "tfe_workspace" "app_workspace" {
  name         = data.aws_ssm_parameter.app_workspace.value
  organization = data.tfe_organization.app_org.name
  project_id   = data.tfe_project.app_project.id
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