output "frontend_instance_id"{
    value = module.general.instance_id

    description = "Frontend - Instance ID of the EC2"
}

output "frontend_security_group_id"{
    value = module.security_group.security_group_id
    
    description = "Frontend - Security group id attached to the instance"
}