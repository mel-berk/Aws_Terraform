//////////////////////////////////////////////////////////////
//
// DOCKER REGISTRIES
//
//////////////////////////////////////////////////////////////
module "frontend_ecr" {
  source    = "cloudposse/ecr/aws"
  version   = "0.32.2"
  name      = "frontend"
  namespace = local.workspace["namespace"]
  stage     = local.workspace["stage"]
}

module "backend_ecr" {
  source    = "cloudposse/ecr/aws"
  version   = "0.32.2"
  name      = "backend"
  namespace = local.workspace["namespace"]
  stage     = local.workspace["stage"]
}
