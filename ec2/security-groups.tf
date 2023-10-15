module "ssh_public_sg" {
  source = "terraform-aws-modules/security-group/aws//modules/ssh"

  name   = "${var.environment}-ssh-access"
  vpc_id = var.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
}

output "ssh_public_sg" {
  value = module.ssh_public_sg.security_group_id
}
