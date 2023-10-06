docker build -t krolm-website .

docker tag krolm-website:latest 394357065274.dkr.ecr.us-west-2.amazonaws.com/krolm-repo

aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin 394357065274.dkr.ecr.us-west-2.amazonaws.com/krolm-repo

docker push 394357065274.dkr.ecr.us-west-2.amazonaws.com/krolm-repo:latest
