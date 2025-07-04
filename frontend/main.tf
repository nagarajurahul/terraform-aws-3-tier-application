module "security_group"{
    source = "../security-group"

    type = "frontend"
    vpc_id = var.vpc_id
}

module "security_group_rules"{
    source = "../security-group-rules/frontend"

    security_group_id = module.security_group.security_group_id
}

module "iam"{
    source = "../iam"

    type = "frontend"
}

module "instance_with_template"{
    source = "../instance-with-template"

    owner = var.owner
    env=var.env
    type = "frontend"
    
    vpc_id = var.vpc_id
    security_group_id = module.security_group.security_group_id
    associate_public_ip_address=var.associate_public_ip_address

    iam_instance_profile_name = module.iam.iam_instance_profile_name
}