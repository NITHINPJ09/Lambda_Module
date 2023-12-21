module "network" {
  source = "./modules/network"
}

module "lambda_security_group" {
  source = "./modules/lambda_security_group"
  vpc_id = module.network.vpc_id

}

module "lambda_iam" {
  source        = "./modules/lambda_iam"
  lambda_bucket = var.lambda_bucket
}

module "lambda_layer" {
  source               = "./modules/lambda_layer"
  lambda_bucket        = var.lambda_bucket
  lambda_layer_zip_key = var.lambda_layer_zip_key
  layer_name           = var.layer_name
}



module "FirstLambda" {
  source               = "./modules/lambda"
  lambda_bucket        = var.lambda_bucket
  lambda_code_zip      = var.lambda_code_first_zip
  lambda_function_name = var.lambda_first_function_name
  handler              = "hello-python.lambda_handler"
  environment          = var.environment
  role                 = module.lambda_iam.lambda_role_arn
  security_group_ids   = module.lambda_security_group.lambda_sg_id
  #include_layers       = false
  layer_arn            = module.lambda_layer.layer_arn
  private_subnets_id   = module.network.private_subnets_id
  depends_on           = [module.network, module.lambda_iam, module.lambda_security_group, module.lambda_layer]
}

module "SecondLambda" {
  source               = "./modules/lambda"
  lambda_bucket        = var.lambda_bucket
  lambda_code_zip      = var.lambda_code_second_zip
  lambda_function_name = var.lambda_second_function_name
  handler              = "hi-python.lambda_handler"
  environment          = var.environment
  role                 = module.lambda_iam.lambda_role_arn
  security_group_ids   = module.lambda_security_group.lambda_sg_id
  include_layers       = false
  layer_arn            = module.lambda_layer.layer_arn
  private_subnets_id   = module.network.private_subnets_id
  depends_on           = [module.network, module.lambda_iam, module.lambda_security_group, module.lambda_layer]
}
