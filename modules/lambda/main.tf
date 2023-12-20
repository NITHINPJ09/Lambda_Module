data "aws_vpc" "existing_vpc" {
  filter {
    name   = "tag:Environment"
    values = ["dev"]
  }

  filter {
    name   = "tag:Name"
    values = ["*vpc*"]
  }
}

# data "aws_subnet" "first_private_subnet" {
#   vpc_id = data.aws_vpc.existing_vpc.id

#   // Filter to select private subnets based on your criteria
#   filter {
#     name   = "tag:Name"
#     values = ["*private-subnet*"]
#   }

#   filter {
#     name   = "availability-zone"
#     values = ["eu-west-3a"] # Replace with the specific Availability Zone you're interested in
#   }

#   // Add more filters as needed
# }

data "aws_subnets" "private_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.existing_vpc.id]
  }

  // Filter to select private subnets based on your criteria
  filter {
    name   = "tag:Name"
    values = ["*private-subnet*"]
  }
  
}

resource "aws_security_group" "lambda_sg" {
  name        = "lambda_security_group"
  description = "Security group for Lambda function"
  vpc_id      = data.aws_vpc.existing_vpc.id # Replace with your VPC ID

  ingress {
    from_port   = 80 # Allow inbound traffic on port 80 (HTTP)
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443 # Allow inbound traffic on port 443 (HTTPS)
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

}

output "vpc_id" {
  value = data.aws_vpc.existing_vpc.id
}

output "private_subnet_ids" {
  value = data.aws_subnets.private_subnets.ids
}

data "aws_s3_bucket" "existing_lambda_bucket" {
  bucket = var.lambda_bucket # Replace with the actual name of your existing S3 bucket
}

data "aws_s3_object" "existing_lambda_object" {
  bucket = data.aws_s3_bucket.existing_lambda_bucket.bucket
  key    = var.lambda_code_zip
}

resource "aws_lambda_function" "terraform_lambda_func" {
  function_name    = var.lambda_function_name
  role             = var.lambda_role_arn
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
  layers = [var.layer_arn]
  #layers = []
  depends_on = [data.aws_s3_bucket.existing_lambda_bucket, aws_cloudwatch_log_group.example]
}

resource "aws_cloudwatch_log_group" "example" {
  name              = "/aws/lambda/${var.lambda_function_name}"
  retention_in_days = 14
}
