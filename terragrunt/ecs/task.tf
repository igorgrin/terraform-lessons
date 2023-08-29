resource "aws_ecs_task_definition" "my_task" {
  family                   = "my-task-family"
  network_mode            = "awsvpc"  # Use awsvpc for Fargate

  execution_role_arn      = aws_iam_role.execution_role.arn

  container_definitions = [
    {
      name  = "my-container"
      image = "nginx:latest"  # Let's run NGINX server

      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = var.container_port
        },
      ]
    },
  ]
}
