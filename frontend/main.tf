module "general"{
    source = "../general"

    owner = var.owner
    env=var.env
    
    vpc_id = var.vpc_id

    type = "frontend"

}

module "security-group"{
    source = "./security-group"

    security_group_id = module.general.security_group_id
}