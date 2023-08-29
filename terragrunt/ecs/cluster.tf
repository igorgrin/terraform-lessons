module "ecs" {
 source  = "terraform-aws-modules/ecs/aws"
 version = "~> 4.1.3"

 cluster_name = var.cluster_name

 # * Let's save some money!
 # * Allocate 20% capacity to FARGATE and then split
 # * the remaining 80% capacity 50/50 between FARGATE
 # * and FARGATE_SPOT.
 fargate_capacity_providers = {
  FARGATE = {
   default_capacity_provider_strategy = {
    base   = 20
    weight = 50
   }
  }
  FARGATE_SPOT = {
   default_capacity_provider_strategy = {
    weight = 50
   }
  }
 }
}
