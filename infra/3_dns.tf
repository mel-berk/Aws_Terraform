data "aws_route53_zone" "main" {
  name     = local.companyName_dns
  provider = aws.ROOT
}

resource "aws_route53_zone" "client_subdomain" {
  name = local.workspace["cert_domain_name"]
  tags = {
    Environment = local.workspace["stage"]
  }
}

resource "aws_route53_record" "client_subdomain_ns" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = local.workspace["cert_domain_name"]
  type    = "NS"
  ttl     = "30"
  records = aws_route53_zone.client_subdomain.name_servers

  provider = aws.ROOT
}
