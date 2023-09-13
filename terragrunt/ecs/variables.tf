variable "dns_domain" {}
variable "dns_domain" {}
variable "vpc_name" {}
variable "vpc_id" {}
variable "public_subnets" {
  type = list(string)
}
variable "private_subnets" {
  type = list(string)
}
variable "sg_http_public" {}
variable "container_port" {
  type = number
}
variable "cluster_name" {}
variable "task_name" {}
variable "service_name" {}
variable "service_scaled" {}

# A list of multiple services
variable "services" {
  type = list(object({
    name            = string
    task_definition = string
  }))
  default = [
    {
      name            = "service-a"
      task_definition = aws_ecs_task_definition.my_task_a.arn
    },
    {
      name            = "service-b"
      task_definition = aws_ecs_task_definition.my_task_b.arn
    },
    {
      name            = "service-c"
      task_definition = aws_ecs_task_definition.my_task_c.arn
    }
  ]
}
