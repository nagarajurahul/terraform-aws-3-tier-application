resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "main"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "My DB subnet group"
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

resource "aws_db_instance" "db_instance" {
  engine               = "mysql"
  engine_version       = "8.0"
  parameter_group_name = "default.mysql8.0"

  db_name              = var.db_name
  
  instance_class       = var.instance_class
  allocated_storage    = 10

  username             = var.username
  password             = var.password
  
  # To avoid snapshots for free-tier
  skip_final_snapshot  = true

  # Imp for point in time recovery
  identifier = "my_db"

  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name


    
    # # If multi-az is needed
    # multi_az = true

    # In days
    # backup_retention_period = 7
    # backup_window = 
    # copy_tags_to_snapshot = true

    # # If want to preserve automated backups
    # delete_automated_backups = false
    # # For secure db - compliance
    # deletion_protection = true
}