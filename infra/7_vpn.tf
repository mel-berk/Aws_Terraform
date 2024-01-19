module "client_vpn" {
  # Change to "count = 0" if you want to disable the vpn
  count                     = local.workspace["is_vpn_enabled"] ? 1 : 0

  source                    = "git::https://gitlab.com/keltiotechnology/terraform/modules/aws/aws-ec2-client-vpn"

  # Provide the path to the files
  certificate_chain         = "${abspath(path.root)}/ca/ca.crt"
  server_private_key        = "${abspath(path.root)}/ca/server.key"
  server_certificate_body   = "${abspath(path.root)}/ca/server.crt"

  vpc_cidr_block            = module.ecs_cluster.vpc_cidr_block
  vpc_id                    = module.ecs_cluster.vpc_id

  vpn_cidr_block            = "10.0.20.0/22"    
  dns_servers               = ["172.16.0.2"] # VPC CIDR Base Network + 2
  subnets                   = module.ecs_cluster.vpc_private_subnet_ids

  vpn_security_group_rules  = [
    {
      "type"                            = "ingress"
      "from_port"                       = 8
      "to_port"                         = 0
      "protocol"                        = "ICMP"
      "security_group_id"               = module.ecs_cluster.vpc_default_security_group_id
    },
    {
      "type"                            = "ingress"
      "from_port"                       = 8000
      "to_port"                         = 8000
      "protocol"                        = "TCP"
      "security_group_id"               = module.ecs_cluster.vpc_default_security_group_id
    }
  ]
  
  vpn_security_group_name   = "companyName-vpn-secgroup"
}
