resource "aws_db_subnet_group" "db_subnet_group" {
  name = "${var.identifier}-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "${var.identifier}-subnet-group"
    Env = var.env
    Owner = var.owner
  }
}

module "security-group"{
    source = "../security-group"

    type = "database"
    vpc_id = var.vpc_id
}

module "security-group-rules"{
    source = "../security-group-rules/database"

    security_group_id = module.security-group.security_group_id
    source_security_group_id = var.source_security_group_id
}

data "aws_secretsmanager_secret_version" "secret_value" {
  secret_id = var.secret_arn
  depends_on = [var.secret_version_id]
}

locals {
  rds_secret = jsondecode(data.aws_secretsmanager_secret_version.secret_value.secret_string)                      
}

resource "aws_db_instance" "db_instance" {
  engine               = "mysql"
  engine_version       = "8.0"
  parameter_group_name = "default.mysql8.0"
  
  instance_class       = var.instance_class
  allocated_storage    = var.allocated_storage
  multi_az = var.rds_multi_az

  db_name              = var.db_name
  username             = local.rds_secret.username
  password             = local.rds_secret.password

  # Imp for point in time recovery
  identifier = var.identifier

  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name

  # To avoid snapshots for free-tier
  skip_final_snapshot  = var.skip_final_snapshot
  deletion_protection = var.deletion_protection
  copy_tags_to_snapshot  = true

  backup_retention_period = 7
  backup_window           = "02:00-03:00"
  maintenance_window      = "Mon:03:00-Mon:04:00"

  tags = {
    Name = "${var.identifier}"
    Env = var.env
    Owner = var.owner
  }
}