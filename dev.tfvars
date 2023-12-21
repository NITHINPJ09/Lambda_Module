region               = "eu-west-3"
environment          = "Development"
lambda_bucket        = "npj-terraform-state"
lambda_layer_zip_key = "python.zip"
layer_name           = "new_layer"
endpoint_path        = "demo"

first_lambda = {
  lambda_code          = "hello-python.zip"
  lambda_function_name = "Lambda-Function-Demo"
  handler              = "hello-python.lambda_handler"
}

second_lambda = {
  lambda_code          = "hi-python.zip"
  lambda_function_name = "Lambda-Function-Sample"
  handler              = "hi-python.lambda_handler"
}