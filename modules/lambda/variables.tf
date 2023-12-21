variable "environment" {
  description = "Deployment Environment"
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

variable "private_subnets_id" {
  description = "ID's of the private subnets"
}

variable "layer_arn" {
  description = "ARN of the layer"
}

variable "role" {
  description = "Lambda role"
}

variable "security_group_ids" {
  
}

variable "include_layers" {
  type    = bool
  default = false
}




