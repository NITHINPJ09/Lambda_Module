module "FirstLambda" {
  source               = "./modules/lambda"
  lambda_role_arn      = aws_iam_role.lambda_role.arn
  lambda_bucket        = var.lambda_bucket
  lambda_code_zip      = var.lambda_code_first_zip
  lambda_function_name = var.lambda_first_function_name
  handler              = "hello-python.lambda_handler"
  environment          = var.environment
}

module "SecondLambda" {
  source               = "./modules/lambda"
  lambda_role_arn      = aws_iam_role.lambda_role.arn
  lambda_bucket        = var.lambda_bucket
  lambda_code_zip      = var.lambda_code_second_zip
  lambda_function_name = var.lambda_second_function_name
  handler              = "hi-python.lambda_handler"
  environment          = var.environment
}