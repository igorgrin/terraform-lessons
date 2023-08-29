module "alb" {
 source  = "terraform-aws-modules/alb/aws"
 version = "~> 8.4.0"

 load_balancer_type = "application"
 security_groups = [var.sg_http_public]
 subnets = var.public_subnets
 vpc_id = var.vpc_id

 http_tcp_listeners = [
  {
   port               = 80
   protocol           = "HTTP"
   target_group_index = 0
  }
 ]

 target_groups = [
  {
   backend_port         = var.container_port
   backend_protocol     = "HTTP"
   target_type          = "ip"
  }
 ]
}
