//
// DATABASE
//
///////////////////////////////
module "rds_instance" {
  source  = "cloudposse/rds/aws"
  version = "0.38.0"

  namespace           = local.workspace["namespace"]
  stage               = local.workspace["stage"]
  name                = var.database_name
  host_name           = ""
  vpc_id              = module.ecs_cluster.vpc_id
  subnet_ids          = module.ecs_cluster.vpc_private_subnet_ids
  security_group_ids  = [module.ecs_cluster.vpc_default_security_group_id]
  ca_cert_identifier  = "rds-ca-2019"
  allowed_cidr_blocks = [module.ecs_cluster.vpc_cidr_block]
  database_name       = jsondecode(data.aws_secretsmanager_secret_version.POSTGRES_DB.secret_string)["POSTGRES_DB"]
  database_user       = jsondecode(data.aws_secretsmanager_secret_version.POSTGRES_USER.secret_string)["POSTGRES_USER"]
  database_password   = jsondecode(data.aws_secretsmanager_secret_version.POSTGRES_PASSWORD.secret_string)["POSTGRES_PASSWORD"]
  database_port       = local.db_port
  multi_az            = local.workspace["db_multi_az"]
  storage_type        = local.workspace["db_storage_type"]
  allocated_storage   = local.workspace["db_allocated_storage"]

  storage_encrypted           = var.database_enabled_storage_encrypted
  engine                      = var.database_engine
  engine_version              = var.database_engine_version
  major_engine_version        = var.database_major_engine_version
  instance_class              = local.workspace["db_instance_class"]
  db_parameter_group          = var.database_parameter_group
  publicly_accessible         = false
  auto_minor_version_upgrade  = true
  allow_major_version_upgrade = false
  apply_immediately           = false
  maintenance_window          = var.database_maintenance_window
  db_parameter                = local.workspace["db_parameters"]

  # https://github.com/hashicorp/terraform-provider-aws/issues/4597
  # If we don't skip final snapshot, terraform cannot delete for us the option group
  # As the option group depends on the snapshot
  # To avoid manually using AWS console to delete associated shot, let's keep it to true
  skip_final_snapshot     = true
  copy_tags_to_snapshot   = true
  backup_retention_period = local.workspace["db_backup_retention_perdiod"]
  backup_window           = var.database_backup_window

  depends_on = [
    module.ecs_cluster
  ]
}
