# State file
State file is critical for the Terraform infrastructure.
The state file keeps track of the actual resources created in the target infrastructure.

The [following code](s3.tf) will create the initial S3 bucket for storing state files.
