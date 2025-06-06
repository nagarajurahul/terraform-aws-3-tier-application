module "instance_with_template"{
    source = "../instance-with-template"

    owner = var.owner
    env=var.env
    type = "backend"

    vpc_id = var.vpc_id 
    

}