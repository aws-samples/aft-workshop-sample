variable "ct_home_region" {
  description = "This MUST be the same region as Control Tower is deployed."
  type        = string
  validation {
    condition     = can(regex("(us(-gov)?|ap|ca|cn|eu|sa)-(central|(north|south)?(east|west)?)-\\d", var.ct_home_region))
    error_message = "Variable var: region is not valid."
  }
}

variable "use_aft_vpc" {
  description = "Set this to true to use AFT Management VPC for CLoud9"
  default     = "false"
  type        = string
  validation {
    condition     = contains(["true","false"], var.use_aft_vpc)
    error_message = "Variable use_aft_vpc: select true or false."
  }
}

variable "c9_instance_profile" {
  description = "Name of the IAM instance profile for Cloud9"
  type        = string
  default     = "cloud9-aft-profile"
}

variable "c9_instance_name" {
  description = "Name of the Cloud9 environment"
  type        = string
  default     = "cloud9-aft"
}