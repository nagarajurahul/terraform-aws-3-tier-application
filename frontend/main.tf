module "security_group"{
    source = "../security-group"

    type = "frontend"
    vpc_id = var.vpc_id
}

module "security_group_rules"{
    source = "./security-group-rules"

    security_group_id = module.security_group.security_group_id
}

module "instance_with_template"{
    source = "../instance-with-template"

    owner = var.owner
    env=var.env
    type = "frontend"
    
    vpc_id = var.vpc_id
    security_group_id = module.security_group.security_group_id

}

