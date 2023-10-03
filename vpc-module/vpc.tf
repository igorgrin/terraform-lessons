module "vpc" {
  # Pull public module
  source = "git@github.com:terraform-aws-modules/terraform-aws-vpc.git"

  name = "MyVPC"
  # Specify IP range
  cidr = "10.0.0.0/8"

  # Create 3 availability zones
  azs             = ["us-west-2a", "us-west-2b", "us-west-2c"]
  public_subnets  = "10.1.0.0/16"
  private_subnets = "10.2.0.0/16"

  # DHCP settings
  enable_dhcp_options      = true
  dhcp_options_domain_name = "test.krolm.com"
  enable_dns_hostnames     = true
  enable_dns_support       = true

  # Gateway is needed for outgoing traffic to reach the Internet
  enable_nat_gateway = true
  single_nat_gateway = true
}

# Outputs are needed for cross-referencing terraform resources
output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}
