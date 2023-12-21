variable "region" {}
variable "environment" {}
variable "lambda_bucket" {}
variable "lambda_layer_zip_key" {}
variable "layer_name" {}
variable "endpoint_path" {}
variable "first_lambda" {
  type = object({
    lambda_code          = string,
    lambda_function_name = string,
    handler              = string
  })
}
variable "second_lambda" {
  type = object({
    lambda_code          = string,
    lambda_function_name = string,
    handler              = string
  })
}







