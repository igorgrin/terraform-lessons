# Update aws cli to the latest version
sudo yum remove awscli
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Update kube config
aws eks --region us-east-1 update-kubeconfig --name demo
