data "aws_region" "current" {}

data "aws_route53_zone" "domain" {
  zone_id = var.zone_id
}
