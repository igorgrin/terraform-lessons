provider "aws" {
  region = "us-west-2" # Specify your desired AWS region
}

resource "aws_s3_bucket" "state_bucket" {
  bucket = "terraform-lessons-state" # Bucket for keeping the TF State file
  acl    = "private"                 # Set the bucket access control list (ACL)
}
