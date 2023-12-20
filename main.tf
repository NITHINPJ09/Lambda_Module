module "FirstLambda" {
  source               = "./modules/lambda"
  lambda_bucket        = var.lambda_bucket
  lambda_code_zip      = var.lambda_code_first_zip
  lambda_function_name = var.lambda_first_function_name
  handler              = "hello-python.lambda_handler"
  environment          = var.environment
  layer_arn            = aws_lambda_layer_version.existing_lambda_layer.arn
}

module "SecondLambda" {
  source               = "./modules/lambda"
  lambda_bucket        = var.lambda_bucket
  lambda_code_zip      = var.lambda_code_second_zip
  lambda_function_name = var.lambda_second_function_name
  handler              = "hi-python.lambda_handler"
  environment          = var.environment
  #layer_arn            = aws_lambda_layer_version.existing_lambda_layer.arn
  layer_arn            = ""
}
