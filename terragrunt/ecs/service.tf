module "ecs_service" {
  source  = "terraform-aws-modules/ecs/aws"
  version = "~> 4.1.3"

  name            = "my-ecs-service"
  cluster         = module.ecs.cluster_id
  task_definition = aws_ecs_task_definition.my_task.arn
  launch_type     = "FARGATE"
  subnet_ids     = var.private_subnets

  capacity_provider_strategy = {
    capacity_provider = "FARGATE"
    weight            = 1
  }

  deployment_controller = {
    type = "ECS"
  }

  desired_count           = 2  # Run two tasks
  depends_on              = [module.ecs]
  enable_ecs_managed_tags = true
}
