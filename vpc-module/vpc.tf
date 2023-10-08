data "aws_availability_zones" "available" {}

module "vpc" {
  # Pull public module
  source = "git@github.com:terraform-aws-modules/terraform-aws-vpc.git"

  name = "tf-lessons-vpc"
  # Specify IP range
  cidr = "10.0.0.0/16"

  # Create 3 availability zones

  # azs = ["us-west-2a", "us-west-2b", "us-west-2c"]
  azs = slice(data.aws_availability_zones.available.names, 0, 3)

  public_subnets = [
    "10.0.0.0/19",
    "10.0.32.0/19",
    "10.0.64.0/19",
  ]
  private_subnets = [
    "10.0.96.0/19",
    "10.0.128.0/19",
    "10.0.160.0/19",
  ]

  public_subnet_tags = {
    "kubernetes.io/role/elb" = "1"
  }
  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = "1"
  }

  # DHCP settings
  enable_dhcp_options      = true
  dhcp_options_domain_name = "krolm.com"
  enable_dns_hostnames     = true
  enable_dns_support       = true

  # Gateway is needed for outgoing traffic to reach the Internet
  enable_nat_gateway = true
  single_nat_gateway = true
}

# Outputs are needed for cross-referencing terraform resources
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "private_subnets" {
  value = module.vpc.private_subnets
}
