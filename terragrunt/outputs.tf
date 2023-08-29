output "dns_main" {
  value = aws_route53_zone.main.id
}

output "dns_domain" {
  value = aws_route53_zone.main.name
}
