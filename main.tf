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