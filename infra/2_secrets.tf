//////////////////////////////////////////////////////////////
//
// APPLICATION SECRETS
//
// Notes :
// - Secrets must be created manually in AWS Secret Manager before apply
//
//////////////////////////////////////////////////////////////
data "aws_secretsmanager_secret" "POSTGRES_DB" {
  name = local.workspace["secret_db_name_path"]
}
data "aws_secretsmanager_secret_version" "POSTGRES_DB" {
  secret_id = data.aws_secretsmanager_secret.POSTGRES_DB.id
}

data "aws_secretsmanager_secret" "POSTGRES_USER" {
  name = local.workspace["secret_db_user_path"]
}
data "aws_secretsmanager_secret_version" "POSTGRES_USER" {
  secret_id = data.aws_secretsmanager_secret.POSTGRES_USER.id
}

data "aws_secretsmanager_secret" "POSTGRES_PASSWORD" {
  name = local.workspace["secret_db_password_path"]
}
data "aws_secretsmanager_secret_version" "POSTGRES_PASSWORD" {
  secret_id = data.aws_secretsmanager_secret.POSTGRES_PASSWORD.id
}

data "aws_secretsmanager_secret" "MAIL_USERNAME" {
  name = local.workspace["secret_mail_username"]
}

data "aws_secretsmanager_secret" "MAIL_PASSWORD" {
  name = local.workspace["secret_mail_password"]
}

data "aws_secretsmanager_secret" "JWT_SECRET" {
  name = local.workspace["secret_jwt_secret"]
}
