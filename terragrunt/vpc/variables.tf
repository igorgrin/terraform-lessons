variable "region" {
  type = string
}

variable "vpc_name" {
  type = string
}

variable "vpc_subnet" {
  type = string
}

variable "dns_domain" {
  type = string
}

variable "dns_zone" {
  type = string
}

variable "public_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

