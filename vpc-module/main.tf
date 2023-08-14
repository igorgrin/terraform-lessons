provider "aws" {
  region = "us-west-2"
}

module "vpc" {
  source = "git@github.com:terraform-aws-modules/terraform-aws-vpc.git"

  name = "MyVPC"
  cidr = "10.0.0.0/16"

  azs             = ["us-west-2a", "us-west-2b", "us-west-2c"]
  private_subnets = var.private_subnet
  public_subnets  = "10.0.1.0/24"

  enable_dhcp_options      = true
  dhcp_options_domain_name = "test.domain.com"
  enable_dns_hostnames     = true
  enable_dns_support       = true

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
