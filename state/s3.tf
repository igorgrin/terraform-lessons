provider "aws" {
  region = "us-west-2" # Specify your desired AWS region
}

# Create the initial terraform-lessons-state S3 bucket
resource "aws_s3_bucket" "state_bucket" {
  bucket = "terraform-lessons-state" # Bucket for keeping the TF State file

  lifecycle {
    prevent_destroy = true
  }

  # Tag fields are case-sensitive
  tags = {
    Name        = "terraform-lessons-state"
    Environment = "test"
  }
}

# Block public access to S3 bucket
resource "aws_s3_bucket_public_access_block" "block_public_access" {
  bucket = aws_s3_bucket.state_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Enable bucket versioning
resource "aws_s3_bucket_versioning" "state_bucket" {
  bucket = aws_s3_bucket.state_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Create the initial KMS key to encrypt this bucket
resource "aws_kms_key" "state_bucket" {
  deletion_window_in_days = 7
  enable_key_rotation     = true
  tags = {
    Environment = "test"
  }
}

# Enable encryption on S3 bucket
resource "aws_s3_bucket_server_side_encryption_configuration" "state_bucket" {
  bucket = aws_s3_bucket.state_bucket.bucket

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.state_bucket.arn
      sse_algorithm     = "aws:kms"
    }
    bucket_key_enabled = true
  }
}
