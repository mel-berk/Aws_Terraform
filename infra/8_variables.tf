/////////////////////////////////////////////////////////////////
//
// COMMON VARIABLES
//
/////////////////////////////////////////////////////////////////
variable "provider_env_roles" {
  type = map(any)
  default = {
    "prod" = "arn:aws:iam::452185648521:role/OrganizationAccountAccessRole"
    "demo" = "arn:aws:iam::108797844887:role/OrganizationAccountAccessRole"
  }
}

/////////////////////////////////////////////////////////////////
//
// ECS
//
/////////////////////////////////////////////////////////////////
variable "ecs_frontend_target_group_name" {
  type        = string
  description = "Ecs frontend target group name"
  default     = "front-tg"
}

variable "ecs_backend_target_group_name" {
  type        = string
  description = "Ecs backend target group name"
  default     = "back-tg"
}

/////////////////////////////////////////////////////////////////
//
// DATABASES
//
/////////////////////////////////////////////////////////////////
variable "database_name" {
  type        = string
  description = "Name of the database in AWS"
  default     = "rds"
}

variable "database_enabled_storage_encrypted" {
  type        = bool
  description = "Specifies whether the DB instance is encrypted. Default is true"
  default     = true
}

variable "database_engine" {
  type        = string
  description = "Database engine type."
  default     = "postgres"
}

variable "database_engine_version" {
  type        = string
  description = "Database engine version."
  default     = "13.3"
}

variable "database_major_engine_version" {
  type        = string
  description = "Major database engine version."
  default     = "13"
}

variable "database_parameter_group" {
  type        = string
  description = "DB parameter group"
  default     = "postgres13"
}

variable "database_maintenance_window" {
  type        = string
  description = "Maintenance_window"
  default     = "Mon:03:00-Mon:04:00"
}

variable "database_backup_retention_period" {
  type        = number
  description = "Backup retention period"
  default     = 1
}

variable "database_backup_window" {
  type        = string
  description = "Backup window"
  default     = "22:00-03:00"
}

variable "bastion_ami" {
  type        = string
  description = "Bastion ami"
  default     = "ami-0f7cd40eac2214b37"
}

variable "bastion_instance_type" {
  type        = string
  description = "Bastion instance type"
  default     = "t3.micro"
}

variable "bastion_deployer_key_name" {
  type        = string
  description = "Bastion deployer key name"
  default     = "ops-key"
}
