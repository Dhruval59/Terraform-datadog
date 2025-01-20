provider "aws" {
  region = "us-east-1"
    access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

provider "datadog" {
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
}

# variables.tf
variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "datadog_api_key" {}
variable "datadog_app_key" {}
variable "enable_datadog" {
  default = true
}
variable "key_name" {}
variable "private_key_path" {}
