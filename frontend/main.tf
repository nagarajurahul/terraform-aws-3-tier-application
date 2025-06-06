module "security_group"{
    source = "../security-group"

    type = "frontend"
    vpc_id = var.vpc_id
}

module "security-group-rules"{
    source = "./security_group_rules"

    security_group_id = module.security_group.security_group_id
}

module "general"{
    source = "../general"

    owner = var.owner
    env=var.env
    type = "frontend"
    
    vpc_id = var.vpc_id
    security_group_id = module.security_group.security_group_id

}

