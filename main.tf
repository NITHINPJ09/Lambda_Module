data "aws_s3_bucket" "existing_lambda_bucket" {
  bucket = var.lambda_bucket # Replace with the actual name of your existing S3 bucket
}

data "aws_s3_object" "existing_lambda_layer" {
  bucket = data.aws_s3_bucket.existing_lambda_bucket.bucket
  key    = "python.zip" # Replace with the actual key of your existing S3 object
}

resource "aws_lambda_layer_version" "existing_lambda_layer" {
  s3_bucket           = data.aws_s3_bucket.existing_lambda_bucket.id
  s3_key              = data.aws_s3_object.existing_lambda_layer.key
  layer_name          = "lambda_package"
  compatible_runtimes = ["python3.8"]
  skip_destroy        = true
  s3_object_version = data.aws_s3_object.existing_lambda_layer.version_id
}

module "FirstLambda" {
  source               = "./modules/lambda"
  lambda_role_arn      = aws_iam_role.lambda_role.arn
  lambda_bucket        = var.lambda_bucket
  lambda_code_zip      = var.lambda_code_first_zip
  lambda_function_name = var.lambda_first_function_name
  handler              = "hello-python.lambda_handler"
  environment          = var.environment
  layer_arn            = aws_lambda_layer_version.existing_lambda_layer.arn
}

module "SecondLambda" {
  source               = "./modules/lambda"
  lambda_role_arn      = aws_iam_role.lambda_role.arn
  lambda_bucket        = var.lambda_bucket
  lambda_code_zip      = var.lambda_code_second_zip
  lambda_function_name = var.lambda_second_function_name
  handler              = "hi-python.lambda_handler"
  environment          = var.environment
  layer_arn            = aws_lambda_layer_version.existing_lambda_layer.arn
}
