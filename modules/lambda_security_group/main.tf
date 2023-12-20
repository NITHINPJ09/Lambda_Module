resource "aws_security_group" "lambda_sg" {
  name        = "lambda_security_group"
  description = "Security group for Lambda function"
  vpc_id      = var.vpc_id 

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
