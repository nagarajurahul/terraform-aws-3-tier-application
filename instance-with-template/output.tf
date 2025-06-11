output "launch_template_id"{
    value = aws_launch_template.launch_template.id
    description = "Template ID of the EC2"
}

output "instance_id"{
    value = aws_instance.instance.id
    description = "Instance ID of the EC2"
}