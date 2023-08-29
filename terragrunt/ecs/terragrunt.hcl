include "root" {
  path = find_in_parent_folders()
}

dependency "root" {
  config_path = path_relative_from_include()
}

dependency "vpc" {
  config_path = "../vpc"
}

inputs = {
  # Root dependencies
  dns_zone         = dependency.root.outputs.dns_main
  dns_domain       = dependency.root.outputs.dns_domain

  # VPC dependencies
  vpc_name        = dependency.vpc.outputs.vpc_name
  vpc_id          = dependency.vpc.outputs.vpc_id
  private_subnets = dependency.vpc.outputs.private_subnets
  public_subnets  = dependency.vpc.outputs.public_subnets
  sg_http_public  = dependency.vpc.outputs.sg_http_public
}
