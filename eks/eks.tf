# Create an EKS cluster
module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "krolm-eks-cluster"
  cluster_version = "1.28"

  vpc_id     = data.terraform_remote_state.vpc_module.outputs.vpc_id
  subnet_ids = data.terraform_remote_state.vpc_module.outputs.public_subnets

  tags = {
    Name        = "krolm-eks-cluster"
    Environment = "dev"
  }
}

## Configure kubectl to access the cluster
#data "aws_eks_cluster" "eks_cluster" {
#  name = module.eks.cluster_name
#}
#
#provider "kubernetes" {
#  host                   = data.aws_eks_cluster.eks_cluster.endpoint
#  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks_cluster.certificate_authority.0.data)
#  token                  = module.eks.cluster_token
#  load_config_file       = false
#  #version                = "~> 1.16"
#}
#
## Output EKS cluster details
#output "eks_cluster_name" {
#  value = module.eks.cluster_name
#}
#
#output "eks_cluster_endpoint" {
#  value = data.aws_eks_cluster.eks_cluster.endpoint
#}
#
#output "eks_cluster_security_group_ids" {
#  value = module.eks.cluster_security_group_ids
#}
#
#output "eks_cluster_subnet_ids" {
#  value = aws_subnet.eks_subnets[*].id
#}
