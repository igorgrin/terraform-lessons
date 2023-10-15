provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket  = "terraform-lessons-state"
    key     = "ec2/terraform.state"
    region  = "us-west-2" # Replace with the desired region
    encrypt = true        # Enable server-side encryption
    #  dynamodb_table = "terraform-lock" # Optional: Use a DynamoDB table for state locking
  }
}
