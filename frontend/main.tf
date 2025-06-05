module "general"{
    source = "../general"

    owner = var.owner
    env=var.env
    
    vpc_id = var.vpc_id

    type = "frontend"

}