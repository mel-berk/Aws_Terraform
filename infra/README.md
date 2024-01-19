<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.1 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >= 2.0 |
| <a name="requirement_ovh"></a> [ovh](#requirement\_ovh) | >= 0.13.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.55.0 |
| <a name="provider_aws.ROOT"></a> [aws.ROOT](#provider\_aws.ROOT) | 3.55.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_backend_ecr"></a> [backend\_ecr](#module\_backend\_ecr) | cloudposse/ecr/aws | 0.32.2 |
| <a name="module_certificate"></a> [certificate](#module\_certificate) | git::https://gitlab.com/keltiotechnology/terraform/modules/aws/aws-domain-cert-acm-with-aws-dns | v1.0.0 |
| <a name="module_cloudfront_certificate"></a> [cloudfront\_certificate](#module\_cloudfront\_certificate) | git::https://gitlab.com/keltiotechnology/terraform/modules/aws/aws-domain-cert-acm-with-aws-dns | v1.0.0 |
| <a name="module_ecs_cluster"></a> [ecs\_cluster](#module\_ecs\_cluster) | git::https://gitlab.com/keltiotechnology/terraform/modules/aws/aws-ecs-cluster | v1.0.0 |
| <a name="module_frontend_ecr"></a> [frontend\_ecr](#module\_frontend\_ecr) | cloudposse/ecr/aws | 0.32.2 |
| <a name="module_rds_instance"></a> [rds\_instance](#module\_rds\_instance) | cloudposse/rds/aws | 0.38.0 |

## Resources

| Name | Type |
|------|------|
| [aws_eip.bastion_floating_ip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_instance.bastion](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_key_pair.ops_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |
| [aws_route53_record.client_subdomain_ns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_zone.client_subdomain](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone) | resource |
| [aws_security_group.bastion_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_route53_zone.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |
| [aws_secretsmanager_secret.MAIL_PASSWORD](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret) | data source |
| [aws_secretsmanager_secret.MAIL_USERNAME](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret) | data source |
| [aws_secretsmanager_secret.POSTGRES_DB](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret) | data source |
| [aws_secretsmanager_secret.POSTGRES_PASSWORD](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret) | data source |
| [aws_secretsmanager_secret.POSTGRES_USER](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret) | data source |
| [aws_secretsmanager_secret_version.POSTGRES_DB](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret_version) | data source |
| [aws_secretsmanager_secret_version.POSTGRES_PASSWORD](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret_version) | data source |
| [aws_secretsmanager_secret_version.POSTGRES_USER](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret_version) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bastion_ami"></a> [bastion\_ami](#input\_bastion\_ami) | Bastion ami | `string` | `"ami-0f7cd40eac2214b37"` | no |
| <a name="input_bastion_deployer_key_name"></a> [bastion\_deployer\_key\_name](#input\_bastion\_deployer\_key\_name) | Bastion deployer key name | `string` | `"ops-key"` | no |
| <a name="input_bastion_instance_type"></a> [bastion\_instance\_type](#input\_bastion\_instance\_type) | Bastion instance type | `string` | `"t3.micro"` | no |
| <a name="input_database_backup_retention_period"></a> [database\_backup\_retention\_period](#input\_database\_backup\_retention\_period) | Backup retention period | `number` | `1` | no |
| <a name="input_database_backup_window"></a> [database\_backup\_window](#input\_database\_backup\_window) | Backup window | `string` | `"22:00-03:00"` | no |
| <a name="input_database_enabled_storage_encrypted"></a> [database\_enabled\_storage\_encrypted](#input\_database\_enabled\_storage\_encrypted) | Specifies whether the DB instance is encrypted. Default is true | `bool` | `true` | no |
| <a name="input_database_engine"></a> [database\_engine](#input\_database\_engine) | Database engine type. | `string` | `"postgres"` | no |
| <a name="input_database_engine_version"></a> [database\_engine\_version](#input\_database\_engine\_version) | Database engine version. | `string` | `"13.3"` | no |
| <a name="input_database_maintenance_window"></a> [database\_maintenance\_window](#input\_database\_maintenance\_window) | Maintenance\_window | `string` | `"Mon:03:00-Mon:04:00"` | no |
| <a name="input_database_major_engine_version"></a> [database\_major\_engine\_version](#input\_database\_major\_engine\_version) | Major database engine version. | `string` | `"13"` | no |
| <a name="input_database_name"></a> [database\_name](#input\_database\_name) | Name of the database in AWS | `string` | `"rds"` | no |
| <a name="input_database_parameter_group"></a> [database\_parameter\_group](#input\_database\_parameter\_group) | DB parameter group | `string` | `"postgres13"` | no |
| <a name="input_ecs_backend_target_group_name"></a> [ecs\_backend\_target\_group\_name](#input\_ecs\_backend\_target\_group\_name) | Ecs backend target group name | `string` | `"back-tg"` | no |
| <a name="input_ecs_frontend_target_group_name"></a> [ecs\_frontend\_target\_group\_name](#input\_ecs\_frontend\_target\_group\_name) | Ecs frontend target group name | `string` | `"front-tg"` | no |
| <a name="input_provider_env_roles"></a> [provider\_env\_roles](#input\_provider\_env\_roles) | ///////////////////////////////////////////////////////////////  COMMON VARIABLES  /////////////////////////////////////////////////////////////// | `map(any)` | <pre>{<br>  "demo": "arn:aws:iam::108797844887:role/OrganizationAccountAccessRole",<br>  "prod": "arn:aws:iam::452185648521:role/OrganizationAccountAccessRole"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_db_instance_id"></a> [db\_instance\_id](#output\_db\_instance\_id) | n/a |
| <a name="output_dns_zone_id"></a> [dns\_zone\_id](#output\_dns\_zone\_id) | n/a |
| <a name="output_ecs_security_group"></a> [ecs\_security\_group](#output\_ecs\_security\_group) | n/a |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | n/a |
| <a name="output_vpc_private_subnet_ids"></a> [vpc\_private\_subnet\_ids](#output\_vpc\_private\_subnet\_ids) | n/a |
| <a name="output_vpc_public_subnet_ids"></a> [vpc\_public\_subnet\_ids](#output\_vpc\_public\_subnet\_ids) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->