# Main DNS zone
resource "aws_route53_zone" "main" {
  name = var.dns_domain
}
