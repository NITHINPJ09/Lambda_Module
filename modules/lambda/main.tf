data "aws_s3_bucket" "existing_lambda_bucket" {
  bucket = var.lambda_bucket # Replace with the actual name of your existing S3 bucket
}

data "aws_s3_object" "existing_lambda_object" {
  bucket = data.aws_s3_bucket.existing_lambda_bucket.bucket
  key    = var.lambda_code_zip
}

resource "aws_lambda_function" "terraform_lambda_func" {
  function_name    = var.lambda_function_name
  role             = var.role
  handler          = var.handler
  runtime          = "python3.8"
  s3_bucket        = data.aws_s3_bucket.existing_lambda_bucket.id
  s3_key           = data.aws_s3_object.existing_lambda_object.key
  s3_object_version = data.aws_s3_object.existing_lambda_object.version_id
  environment {
    variables = {
      S3_BUCKET_NAME = data.aws_s3_bucket.existing_lambda_bucket.id
    }
  }
  layers = var.include_layers ? [var.layer_arn] : []
  #layers = [var.layer_arn]
  #layers = []
  vpc_config {
    subnet_ids         = var.private_subnets_id
    security_group_ids = [var.security_group_ids] # Add security group IDs if necessary
  }
  depends_on = [data.aws_s3_bucket.existing_lambda_bucket, aws_cloudwatch_log_group.example]
}

resource "aws_cloudwatch_log_group" "example" {
  name              = "/aws/lambda/${var.lambda_function_name}"
  retention_in_days = 14
}
