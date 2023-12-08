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
  layer_name          = "my_layer"
  compatible_runtimes = ["python3.8"]
  skip_destroy        = false
  s3_object_version   = data.aws_s3_object.existing_lambda_layer.version_id
}
