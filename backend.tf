terraform {
  backend "s3" {
    bucket = "npj-terraform-state"
    key    = "AWSlambda/terraform.tfstate"
    region = "eu-west-3"
    dynamodb_table  = "dynamodb-state-locking"
  }
}
