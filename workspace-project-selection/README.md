# Create workspace on designated organization, workspace and project name

## How to use

Add the sample [PROJECT](./PROJECT/) into your AFT Account Customizations repository.

Generate Terraform Cloud token and store it in the AWS Secrets Manager secret called `/tfc/token` in the AFT Management account.

Use the sample AFT Account Request module below to refer the customization

```
module "sandbox" {
 source = "./modules/aft-account-request"


 control_tower_parameters = {
   AccountEmail              = "<ACCOUNT EMAIL>"
   AccountName               = "sandbox-aft"
   ManagedOrganizationalUnit = "Learn AFT"
   SSOUserEmail              = "<SSO EMAIL>"
   SSOUserFirstName          = "Sandbox"
   SSOUserLastName           = "AFT"
 }


 account_tags = {
   "Learn Tutorial" = "AFT"
 }


 change_management_parameters = {
   change_requested_by = "HashiCorp Learn"
   change_reason       = "Learn AWS Control Tower Account Factory for Terraform"
 }


 custom_fields = {
    app_org       = "application"
    app_project   = "my-project"
    app_workspace = "unique-workspace-name"
 }

 account_customizations_name = "SANDBOX"
}
```