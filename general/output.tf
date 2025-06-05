output "instance_id"{
    value = aws_instance.instance.id
    description = "Instance ID of the EC2"
}

output "security_group_id" {
    value = aws_security_group.security_group.id
    description = "Security group id attached to the instance"
}