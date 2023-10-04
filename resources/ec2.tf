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

  tags = {
    Name        = "test"
    Environment = "dev"
  }
}

output "public_dns" {
  value = module.ec2_instance.public_dns
}
