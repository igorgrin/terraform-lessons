# Region and S3 state bucket
locals {
  region       = "us-west-2"
  state_bucket = "terraform-lessons-state"
}

remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket = local.state_bucket

    key            = "${path_relative_to_include()}/terraform.state"
    region         = local.region
    encrypt        = true
    dynamodb_table = "terraform-state-lock"  # DynamoDB is needed to lock the state file
  }
}
