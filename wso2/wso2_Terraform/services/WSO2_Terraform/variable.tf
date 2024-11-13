variable "amiID" {
  description = "Provide value of your AMI ID"
  type        = string
  default     = "ami-0123b531fc646552f"

}

variable "instanceType" {
  description = "Select the instance type"
  type        = string
  default     = "c5.large"
}

variable "access_key" {
  description = "Value of access_key of your provisioned IAM"
  type        = string
  default     = ""
}
variable "secret_key" {
  description = "Enter the value of your secret key . Please do not add here for safety"
  type        = string
  default     = ""
}
variable "region" {
  description = "Enter the region which you want to deploy"
  type        = string
  default     = "ap-south-1"
}
variable "securityName" {
  default = "ModuleTest"
}

variable "InstanceName" {
  default = "AmitModuleTest"
}

variable "envName" {
  default = "Stage"
}

//
variable "securityDescription" {
  default = "Testing security group module"
}

variable "backendkeyName" {
  default = "test"
}