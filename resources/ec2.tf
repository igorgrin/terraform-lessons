module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "test"

  instance_type = "t2.micro"
  key_name      = "admin-key"
  monitoring    = false
  vpc_security_group_ids = [
    data.terraform_remote_state.vpc_module.outputs.ssh_public_sg,
  ]
  subnet_id                   = data.terraform_remote_state.vpc_module.outputs.public_subnets[0]
  associate_public_ip_address = true
  user_data                   = var.user_data

  tags = {
    Name        = "test"
    Environment = "dev"
  }
}

# DNS name external
resource "aws_route53_record" "ec2_instance_external" {
  zone_id = aws_route53_zone.main.id
  name    = "test"
  type    = "A"
  ttl     = 300
  records = [module.ec2_instance.public_ip]
}

output "public_dns" {
  value = module.ec2_instance.public_dns
}
