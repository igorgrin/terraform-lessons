# Terraform lessons
Terraform became de facto the default language for managing Public Clouds.  Here are some examples in setting up AWS environment using terraform code.

1. [Create State file bucket](/state)  
   \- Why?  
   \- State file is critical to Terraform infrastructure.  By default, Terraform creates a state file in your local directory.  If you have multiple people managing the code, they would overlap and overwrite each other's changes.  The best practice is to keep the state file in the remote location with a locking mechanism during the terraform run.

2.  [Create VPC](/vpc)  
 \- Why?  
 \- Amazon gives you the default VPC where you can create resources.  The problem with using the default VPC is that you can't reference existing resources without hard-coding their values, since Terraform has no knowledge of them.  For example, if you create an ec2 instance, you have to reference a subnet, so you'd have to put something like `subnet-0da478ea6a3b241c0` in your code.
Also you'd have more granular control over your Infrastructure.

3.  [Create VPC using a module](/vpc-module)  
 \- Why?  
 \- As you can see in the [previous code](/vpc), the code is very long because you have to specify every resource needed for VPC creation.  There are many [public Terraform modules](https://registry.terraform.io/namespaces/terraform-aws-modules) available, where people have pre-built all the necessary components. 
