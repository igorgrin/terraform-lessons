# Create an EKS cluster
module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "krolm-eks-cluster"
  cluster_version = "1.28"

  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

  vpc_id     = data.terraform_remote_state.vpc_module.outputs.vpc_id
  subnet_ids = data.terraform_remote_state.vpc_module.outputs.private_subnets

  eks_managed_node_groups = {
    general = {
      desired_size = 1
      min_size     = 1
      max_size     = 3

      labels = {
        role = "general"
      }

      instance_types = ["t2.small"]
      capacity_type  = "ON_DEMAND"

    }
  }

  tags = {
    Name        = "krolm-eks-cluster"
    Environment = "dev"
  }
}

## Configure kubectl to access the cluster
data "aws_eks_cluster" "eks_cluster" {
  name = module.eks.cluster_name
}

data "aws_eks_cluster_auth" "eks_cluster" {
  name = module.eks.cluster_name
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.eks_cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks_cluster.certificate_authority.0.data)
  #  token                  = module.eks.cluster_token

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.eks_cluster.id]
    command     = "aws"
  }
}

# Output EKS cluster details
output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  value = data.aws_eks_cluster.eks_cluster.endpoint
}
