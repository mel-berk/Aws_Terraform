output "vpc_id" {
  value = module.ecs_cluster.vpc_id
}

output "vpc_public_subnet_ids" {
  value = module.ecs_cluster.vpc_public_subnet_ids
}

output "vpc_private_subnet_ids" {
  value = module.ecs_cluster.vpc_private_subnet_ids
}

output "ecs_security_group" {
  value = module.ecs_cluster.ecs_security_group
}

output "db_instance_id" {
  value = module.rds_instance.instance_id
}

output "dns_zone_id" {
  value = aws_route53_zone.client_subdomain.zone_id
}
