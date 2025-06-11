module "security_group"{
    source = "../security-group"

    type = "backend"
    vpc_id = var.vpc_id
}

module "security_group_rules"{
    source = "../security-group-rules/backend"

    security_group_id = module.security_group.security_group_id
    source_security_group_id = var.source_security_group_id
    backend_port = var.backend_port
}

module "iam"{
    source = "../iam"

    type = "backend"
}

module "instance_with_template"{
    source = "../instance-with-template"

    owner = var.owner
    env=var.env
    type = "backend"
    
    vpc_id = var.vpc_id
    security_group_id = module.security_group.security_group_id
    associate_public_ip_address=var.associate_public_ip_address

    iam_instance_profile_name = module.iam.iam_instance_profile_name
}