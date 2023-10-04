# An example of scaling ECS service when it reaches 60% CPU
module "ecs_service_scaled" {
  source  = "terraform-aws-modules/ecs/aws"
  version = "~> 4.1.3"

  name            = var.service_scaled
  cluster         = module.ecs.cluster_id
  task_definition = aws_ecs_task_definition.my_task.arn
  launch_type     = "FARGATE"
  subnet_ids      = var.private_subnets

  capacity_provider_strategy = {
    capacity_provider = "FARGATE"
    weight            = 1
  }

  deployment_controller = {
    type = "ECS"
  }

  desired_count           = 2 # Run two tasks
  depends_on              = [module.ecs]
  enable_ecs_managed_tags = true
}

# Auto-scaling target
resource "aws_appautoscaling_target" "ecs_service_target" {
  max_capacity       = 10
  min_capacity       = 1
  resource_id        = "service/${module.ecs.cluster_name}/${module.ecs_service.service_scaled}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

# Auto-scaling policy
resource "aws_appautoscaling_policy" "ecs_service_scaling_policy" {
  name               = "ecs-service-scaling-policy"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs_service_target.id
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
    target_value = 60 # Scale up at 60% CPU
  }
}
