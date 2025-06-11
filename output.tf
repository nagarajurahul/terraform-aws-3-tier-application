# output "frontend_instance_id"{
#     value = module.frontend.frontend_instance_id

#     description = "Frontend - Instance ID of the EC2"
# }

# output "frontend_security_group_id"{
#     value = module.frontend.frontend_security_group_id
    
#     description = "Frontend - Security group id attached to the instance"
# }

# output "backend_instance_id"{
#     value = module.backend.backend_instance_id

#     description = "Backend - Instance ID of the EC2"
# }

# output "backend_security_group_id"{
#     value = module.backend.backend_security_group_id
    
#     description = "Backend - Security group id attached to the instance"
# }

output "rds_endpoint" {
  value     = module.database.rds_endpoint
  sensitive = true
}
