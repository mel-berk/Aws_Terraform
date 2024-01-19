provider "aws" {
  region = "eu-west-3"

  assume_role {
    role_arn = var.provider_env_roles[terraform.workspace]
  }
}

provider "aws" {
  region = "eu-west-3"
  alias  = "ROOT"
}

provider "aws" {
  region = "us-east-1"
  alias  = "US"

  assume_role {
    role_arn = var.provider_env_roles[terraform.workspace]
  }
}
