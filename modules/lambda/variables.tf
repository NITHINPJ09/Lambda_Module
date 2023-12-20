variable "environment" {
  description = "Deployment Environment"
}

variable "lambda_role_arn" {
  description = "Name of the lambda role"
}

variable "lambda_bucket" {
  description = "Name of the lambda bucket"
}

variable "lambda_code_zip" {
  description = "Name of the lambda code zip"
}

variable "lambda_function_name" {
  description = "Name of the lambda function"
}

variable "handler" {
  description = "Name of the handler"
}

variable "vpc_id" {
  description = "ID of the VPC"
}

variable "private_subnets_id" {
  description = "ID's of the private subnets"
}



