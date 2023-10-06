provider "aws" {
  region = "us-west-2" # Specify your desired AWS region
}

terraform {
  backend "s3" {
    bucket  = "terraform-lessons-state"
    key     = "eks/terraform.state"
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
