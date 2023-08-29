resource "aws_ecs_task_definition" "my_task" {
  family                  = "${var.task_name}-family"
  network_mode            = "awsvpc"

  execution_role_arn      = aws_iam_role.execution_role.arn

  container_definitions = [
    {
      name  = var.task_name
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
