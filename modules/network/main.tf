data "aws_vpc" "existing_vpc" {
  filter {
    name   = "tag:Environment"
    values = [var.environment]
  }

  filter {
    name   = "tag:Name"
    values = ["*vpc*"]
  }
}


data "aws_subnets" "private_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.existing_vpc.id]
  }

  filter {
    name   = "tag:Name"
    values = ["*private-subnet*"]
  }
  
}

data "aws_security_group" "default" {
  name = "${var.environment}-default-sg"
}

