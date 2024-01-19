//////////////////////////////////////////////////////////////
//
// CERTIFICATES
//
//////////////////////////////////////////////////////////////
module "certificate" {
  source = "git::https://gitlab.com/keltiotechnology/terraform/modules/aws/aws-domain-cert-acm-with-aws-dns?ref=v1.0.0"

  hosted_zone_id = aws_route53_zone.client_subdomain.zone_id
  domain_name    = local.workspace["cert_domain_name"]
  // Cannot put more than 10 alternative name in the certificate so we have to put wildcard ()
  subject_alternative_names = local.workspace["cert_subject_alternative_names"]
}

module "cloudfront_certificate" {
  source = "git::https://gitlab.com/keltiotechnology/terraform/modules/aws/aws-domain-cert-acm-with-aws-dns?ref=v1.0.0"

  hosted_zone_id = aws_route53_zone.client_subdomain.zone_id
  domain_name    = local.workspace["cert_domain_name"]
  // Cannot put more than 10 alternative name in the certificate so we have to put wildcard ()
  subject_alternative_names = local.workspace["cert_subject_alternative_names"]

  providers = {
    aws = aws.US
  }
}

//////////////////////////////////////////////////////////////
//
// ECS CLUSTER
//
//////////////////////////////////////////////////////////////
module "ecs_cluster" {
  source = "git::https://gitlab.com/keltiotechnology/terraform/modules/aws/aws-ecs-cluster?ref=v1.0.0"
  region = local.workspace["region"]

  namespace = local.workspace["namespace"]
  stage     = local.workspace["stage"]

  availability_zones = local.workspace["availability_zones"]

  iam_task_execution_allowed_secrets_arn = [
    data.aws_secretsmanager_secret.POSTGRES_DB.arn,
    data.aws_secretsmanager_secret.POSTGRES_USER.arn,
    data.aws_secretsmanager_secret.POSTGRES_PASSWORD.arn,
    data.aws_secretsmanager_secret.MAIL_USERNAME.arn,
    data.aws_secretsmanager_secret.MAIL_PASSWORD.arn,
    data.aws_secretsmanager_secret.JWT_SECRET.arn
  ]

  lb_default_certificate_arn = module.certificate.aws_acm_certificate_arn

  cloudfront_distributions = [
    {
      aliases             = concat([local.workspace["cert_domain_name"]], local.workspace["cert_subject_alternative_names"]),
      price_class         = local.workspace["cloudfront_price_class"]
      acm_certificate_arn = module.cloudfront_certificate.aws_acm_certificate_arn
    }
  ]

  // Put very big timeout for load balancer due to generate route
  lb_idle_timeout = local.workspace["lb_idle_timeout"]
  target_groups = [
    {
      "name"        = "${local.workspace["namespace"]}-${local.workspace["stage"]}-${var.ecs_frontend_target_group_name}",
      "port"        = local.front_target_port
      "target_type" = "ip"
    },
    {
      "name"        = "${local.workspace["namespace"]}-${local.workspace["stage"]}-${var.ecs_backend_target_group_name}",
      "port"        = local.back_target_port
      "target_type" = "ip"
    }
  ]
}
