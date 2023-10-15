module "test_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = var.instance_name

  instance_type = var.instance_type
  key_name      = "admin-key"
  monitoring    = false
  vpc_security_group_ids = [
    module.ssh_public_sg.security_group_id,
  ]
  subnet_id                   = var.public_subnet1
  associate_public_ip_address = true
  user_data                   = var.user_data

  tags = {
    Name        = var.instance_name
    Environment = var.environment
  }
}

# DNS name external
data "aws_route53_zone" "main_zone" {
  name = var.dns_domain
}

resource "aws_route53_record" "ec2_instance_external" {
  zone_id = data.aws_route53_zone.main_zone.zone_id
  name    = var.instance_name
  type    = "A"
  ttl     = 300
  records = [module.test_instance.public_ip]
}

output "public_dns" {
  value = module.test_instance.public_dns
}
