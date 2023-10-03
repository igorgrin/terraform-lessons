# State file
State file is critical for the Terraform infrastructure.
The state file keeps track of the actual resources created in the target infrastructure.

Essentually there are 3 components:
- Terraform code itself
- Actual resources in AWS
- Terraform state file

Every time you run `terraform plan`, terraform will pull the actual resources from AWS, run terraform code and compaire the code against the State file.  Any discrepancies will show in the run.

The [following code](s3.tf) will create the initial S3 bucket for storing state files.
