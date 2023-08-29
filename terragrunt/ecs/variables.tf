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
variable "service_name" {}
variable "task_name" {}
