resource "aws_key_pair" "ops_key" {
  key_name   = "${local.workspace["namespace"]}-${local.workspace["stage"]}-ops-key"
  public_key = local.workspace["bastion_ops_public_key"]
}

resource "aws_security_group" "bastion_security_group" {
  name        = "${local.workspace["namespace"]}-${local.workspace["stage"]}-bastion-secgroup"
  description = "Controls access to the bastion"
  vpc_id      = module.ecs_cluster.vpc_id

  # Allow incoming HTTP traffic from cloudfront
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow any outcoming traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name      = "${local.workspace["namespace"]}-${local.workspace["stage"]}-bastion-secgroup"
    namespace = local.workspace["namespace"]
    stage     = local.workspace["stage"]
  }
}

# User data
# sudo apt update
# sudo apt install -y postgresql-client
#
# PGPASSWORD=POSTGRES_PASSWORD psql -h 172.16.32.168 -p 8000 -d POSTGRES_DB -U POSTGRES_USER
# Pour drop la database complète :
# DROP SCHEMA public CASCADE;
# CREATE SCHEMA public;

resource "aws_instance" "bastion" {
  ami                         = var.bastion_ami
  instance_type               = var.bastion_instance_type
  key_name                    = aws_key_pair.ops_key.key_name
  associate_public_ip_address = true

  tags = {
    Name = "${local.workspace["namespace"]}-${local.workspace["stage"]}-bastion"
  }

  vpc_security_group_ids = [
    module.rds_instance.security_group_id,
    aws_security_group.bastion_security_group.id
  ]
  subnet_id  = module.ecs_cluster.vpc_public_subnet_ids[0]
  monitoring = true

  root_block_device {
    volume_size = 50
  }
}

resource "aws_eip" "bastion_floating_ip" {
  vpc      = true
  instance = aws_instance.bastion.id
}
