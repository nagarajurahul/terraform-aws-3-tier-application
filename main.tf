terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# module "frontend" {
#     source = "./frontend"

#     owner = var.owner
#     env=var.env
#     vpc_id = var.vpc_id
# }

# module "backend" {
#     source = "./backend"
    
#     owner = var.owner
#     env=var.env
#     vpc_id = var.vpc_id

#     source_security_group_id = module.frontend.frontend_security_group_id
#     backend_port = var.backend_port
# }

module "secrets-manager" {
  source = "./secrets-manager"
  
  owner = var.owner
  env=var.env

  name = "database"
  username = var.username
  password = var.password
}

module "database"{
    source = "./database"

    # source_security_group_id = module.backend.backend_security_group_id
    source_security_group_id = var.backend_security_group_id
    vpc_id = var.vpc_id
    subnet_ids = var.subnet_ids

    env = var.env
    owner = var.owner

    username = var.username
    password = var.password
    skip_final_snapshot = var.skip_final_snapshot
    deletion_protection = var.deletion_protection
    rds_multi_az = var.rds_multi_az

    secret_version_id = module.secrets.secret_version_id

    depends_on = [module.secrets]
    secret_id = module.secrets-manager.secret_id
}