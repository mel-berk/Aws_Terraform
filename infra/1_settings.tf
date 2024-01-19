////////////////////////////////////////////////////////////////////
// companyName INFRA INIT
////////////////////////////////////////////////////////////////////
// This code will create for each env :
// - One VPC
// - Two subnet per availability zone (one public and one private)
// - One load balancer for all applications
// - One certificate for all applications present in the env
// - One ecs cluster
// - Two ECR registries (one for frontend image and one for backend image)
// - One RDS instance
// Time to provision : 20 à 40 min
// Notes: Make sur to change vars depending on environnements (prod, dev, demo) otherwise pricing or availability setiings will not be correct
locals {
  companyName_dns = "melberk.cloud"

  env = {
    defaults = {
      region    = "eu-west-3"
      namespace = "companyName"

      lb_idle_timeout = 60
      db_parameters = [
        {
          name         = "max_connections"
          value        = "10000"
          apply_method = "pending-reboot"
        }
      ]
      db_backup_retention_perdiod = 21
      bastion_ops_public_key      = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCzUQnBWHr6Jn+bZpVXkdic/KfPTJGsR2AwdhRwWw0KslJeujg9LKzynKewwWy64Ice9CB087Z0E0lg3t0O+JDCI6SMv/Am1tNsXueUN4E8BWjnXmf2r/g4CRUXB/66pKEuP++HsGf4xBO/cRQCz2eJHElGT54gDut9l0ktBXhCkbPY5YIpf0lMni9eISlNp0Bm729JDsG2qomyW7s3ZZmSLnc/i0CTitmE7j3AAj/hUMZNiNcpE67X9Fv7srKZ85Q+jpc+AAeXAJ6tpKb8tKYJqW5I+zZufOyCuIgx8WvhjzO+80S40q6naIQkCqcejaCP2tksgQnctIG0lzTv0Hy3qpmZZ482+NIplXLgMc0j/eCXDH4Kv9CtFltR7LbcbMsfmsY3+94838pFt2XUvNW+NoUS96HWGbabU2wt/l1otnHLyI9i+9LximAj2dPcQgXnvJp3kqW/Vo/w4plVwj0Lg56Msks1+TW+gWMKLyPwy9KJ1AryUZXPK0ncaFWJeWRAnK/sazGOL+/jH2XIaoUqyMDt7Y18nfz62cYG507EtYowCBSEZp9mPEZp3kuXuEwxgSSqGLiLZB3Tw0Qmdz4WtjnPKqPZTYXEWXvtPdoFE/73J3Phnrcz8xQm9BPMlEM0rR3//FJyO++q0KhirlMPlRHd+wHtOBifghI67BS15xyw== mouhcine.elber@gmail.com"
    }
    prod = {
      account_id = "452185648521"

      stage              = "prod"
      availability_zones = ["eu-west-3a", "eu-west-3b"]
      cert_domain_name   = "smmrgv.melberk.cloud"
      cert_subject_alternative_names = [
        "app.smmrgv.melberk.cloud",
        "www.app.smmrgv.melberk.cloud",
        "www.smmrgv.melberk.cloud",
        "api.smmrgv.melberk.cloud",
        "www.api.smmrgv.melberk.cloud"
      ],
      cloudfront_price_class = "PriceClass_100"
      db_instance_class    = "db.t3.micro" # For dev or demo : "db.t3.micro", for prod use :"db.t3.small"
      db_storage_type      = "gp2"         # For dev or demo : "standard", for prod use : "gp2"
      db_allocated_storage = 20            # Can be upgraded later so keep it small (1.4$/Go/month :p)
      db_multi_az          = true          # For dev or demo : "false", for prod use: "true"
      is_vpn_enabled       = false

      secret_db_name_path     = "PROD/POSTGRES_DB"
      secret_db_user_path     = "PROD/POSTGRES_USER"
      secret_db_password_path = "PROD/POSTGRES_PASSWORD"
      secret_mail_username    = "PROD/MAIL_USERNAME"
      secret_mail_password    = "PROD/MAIL_PASSWORD"
      secret_jwt_secret       = "PROD/JWT_SECRET"
    }
  }
  workspace = merge(local.env["defaults"], local.env[terraform.workspace])

  # Internal settings (DO NOT TOUCH)
  front_target_port = 3000
  back_target_port  = 3000
  db_port           = 8000
}
