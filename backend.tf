terraform {
  backend "s3" {
    bucket = "npj-terraform-state"
    key    = "lambda/terraform.tfstate"
    region = "eu-west-3"
  }
}