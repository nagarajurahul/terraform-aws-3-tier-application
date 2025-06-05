provider "aws" {
}

data "aws_ami" "ubuntu"{
    owners = ["amazon"]

    most_recent = true
    
    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
    }

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }

}

resource "aws_launch_template" "frontend"{
    name = "frontend-launch-template"
    description = "Launch template for frontend"

    image_id = data.aws_ami.ubuntu.image_id

    instance_type = var.instance-type

    tag_specifications {
        resource_type = "instance"

        tags = {
            Type = "frontend"
            Name = "frontend-instance"
        }
    }

     tags = {
        TemplateOwner = "Owner"
        Env           = "production"
    }

    update_default_version = true

    # For compliance
    # disable_api_stop        = true
    # disable_api_termination = true

    # For hibernation
    hibernation_options {
        configured = var.hibernation-mode
    }
}

resource "aws_instance" "frontend"{
    associate_public_ip_address = true

    launch_template {
      id = aws_launch_template.frontend.id
    }
}