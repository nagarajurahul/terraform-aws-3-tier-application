output "backend_instance_id"{
    value = module.instance_with_template.instance_id

    description = "Backend - Instance ID of the EC2"
}

output "backend_security_group_id"{
    value = module.security_group.security_group_id
    
    description = "Backend - Security group id attached to the instance"
}