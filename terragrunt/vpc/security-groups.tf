resource "aws_security_group" "http_public" {
  name        = "http-public"
  vpc_id      = module.vpc.vpc_id
  ingress {
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    description = "Permit incoming HTTP requests from the internet"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
    description = "Permit all outgoing requests to the internet"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name        = "http-public"
  }
}
