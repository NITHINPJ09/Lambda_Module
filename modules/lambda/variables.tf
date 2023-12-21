variable "environment" {}
variable "lambda_bucket" {}
variable "lambda_code_zip" {}
variable "lambda_function_name" {}
variable "handler" {}
variable "private_subnets_id" {}
variable "layer_arn" {}
variable "role" {}
variable "security_group_ids" {}
variable "include_layers" {
  type    = bool
  default = false
}




