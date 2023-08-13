# Terraform lessons
Terraform became de facto the default language in managing Public Clouds.  Here are some examples in setting up AWS environment using terraform code.

Essentually there are 3 components:
- Terraform code itself
- Actual resources in AWS
- Terraform state file

Every time you run `terraform plan`, terraform will pull the actual resources from AWS, run terraform code and compaire the code against the State file.  Any discrepancies will show in the run.
