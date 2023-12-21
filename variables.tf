variable "region" {
  description = "AWS Region"
}

variable "environment" {
  description = "Deployment Environment"
}

variable "lambda_bucket" {
  description = "Name of the lambda bucket"
}

variable "lambda_layer_zip_key" {
}

variable "layer_name" {
}

variable "first_lambda" {
  description = "Variables for the first_lambda"
  type = object({
    lambda_code          = string,
    lambda_function_name = string,
    handler              = string
  })
}

variable "second_lambda" {
  description = "Variables for the second_lambda"
  type = object({
    lambda_code          = string,
    lambda_function_name = string,
    handler              = string
  })
}





