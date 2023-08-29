module "vpc" {
  source = "git@github.com:terraform-aws-modules/terraform-aws-vpc.git"

  name = var.vpc_name
  cidr = var.vpc_subnet

  azs                           = ["${var.region}a", "${var.region}b", "${var.region}c"]
  private_subnets               = var.private_subnets
  public_subnets                = var.public_subnets
  map_public_ip_on_launch       = true
  manage_default_network_acl    = false
  manage_default_route_table    = false
  manage_default_security_group = false
  manage_default_vpc            = false

  enable_ipv6 = false

  enable_dhcp_options      = true
  enable_dns_hostnames     = true
  enable_dns_support       = true

  enable_nat_gateway = true
  single_nat_gateway = true

  public_subnet_tags = {
    Name = "public-subnets"
  }

  private_subnet_tags = {
    Name = "private-subnets"
  }

  vpc_tags = {
    Name = var.vpc_name
  }
}
