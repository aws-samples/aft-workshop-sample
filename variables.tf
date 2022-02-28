# Update Alternate Contacts
variable "aws_ct_mgt_account_id" {
  description = "Control Tower Management Account Id"
  type        = string
  validation {
    condition     = can(regex("^\\d{12}$", var.aws_ct_mgt_account_id))
    error_message = "Variable var: aws_ct_mgt_account_id is not valid."
  }
}

variable "aws_ct_mgt_org_id" {
  description = "Control Tower Organization Id"
  type        = string
  validation {
    condition     = can(regex("^o-[a-z,0-9]{10}$", var.aws_ct_mgt_org_id))
    error_message = "Variable var: aws_ct_mgt_org_id is not valid."
  }
}

variable "cloudwatch_log_group_retention" {
  description = "Lambda CloudWatch log group retention period"
  type            = string
  default         = "0"
  validation {
    condition     = contains(["1", "3", "5", "7", "14", "30", "60", "90", "120", "150", "180", "365", "400", "545", "731", "1827", "3653", "0"], var.cloudwatch_log_group_retention)
    error_message = "Valid values for var: cloudwatch_log_group_retention are (1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, 3653, and 0)."
  }
}