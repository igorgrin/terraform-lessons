provider "aws" {
  region = "us-west-2"
}

terraform {
  backend "s3" {
    bucket  = "terraform-lessons-state"
    key     = "vpc-module/terraform.state"
    region  = "us-west-2" # Replace with the desired region
    encrypt = true        # Enable server-side encryption
    #  dynamodb_table = "terraform-lock" # Optional: Use a DynamoDB table for state locking
  }
}