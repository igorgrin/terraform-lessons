provider "aws" {
  region = "us-west-2" # Specify your desired AWS region
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.default.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.default.certificate_authority.0.data)
  #  token                  = module.eks.cluster_token

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.default.name]
    command     = "aws"
  }
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.default.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.default.certificate_authority[0].data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.default.id]
      command     = "aws"
    }
  }
}

terraform {
  backend "s3" {
    bucket  = "terraform-lessons-state"
    key     = "eks/config/terraform.state"
    region  = "us-west-2" # Replace with the desired region
    encrypt = true        # Enable server-side encryption
  }
}

# Use data from vpc-module
data "terraform_remote_state" "vpc_module" {
  backend = "s3"
  config = {
    bucket = "terraform-lessons-state"
    key    = "vpc-module/terraform.state"
    region = "us-west-2"
  }
}

# Use data from eks
data "terraform_remote_state" "eks" {
  backend = "s3"
  config = {
    bucket = "terraform-lessons-state"
    key    = "eks/terraform.state"
    region = "us-west-2"
  }
}
