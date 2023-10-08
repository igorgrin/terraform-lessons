## Create AWS profile with keys
aws configure --profile krolm

## Use that profile to get access to eks
aws eks --region us-west-2 --profile krolm update-kubeconfig --name krolm-eks-cluster

Added new context ...:cluster/krolm-eks-cluster to ~/.kube/config
