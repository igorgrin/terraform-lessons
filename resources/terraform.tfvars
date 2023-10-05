region     = "us-west-2"
dns_domain = "krolm.com"
user_data  = <<-EOT
  #!/bin/bash
  yum install -y git screen
  sudo mkdir /mnt/data
  echo "/dev/xvdh /mnt/data xfs defaults,nofail 0 2" | sudo tee -a /etc/fstab
  sudo mount -a
  ln -s /mnt/data/src /home/ec2-user/src
  sudo yum install -y yum-utils
  sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
  sudo yum -y install terraform
EOT
