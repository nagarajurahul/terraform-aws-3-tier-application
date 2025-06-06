terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

module "frontend" {
    source = "./frontend"

    owner = var.owner
    env=var.env
    vpc_id = var.vpc_id
}

module "backend" {
    source = "./backend"
    
    owner = var.owner
    env=var.env
    vpc_id = var.vpc_id
}

module "database"{
    source = "./database"

    source_security_group_id = module.backend.backend_security_group_id
    vpc_id = var.vpc_id
    subnet_ids = var.subnet_ids

    username = var.username
    password = var.password
}