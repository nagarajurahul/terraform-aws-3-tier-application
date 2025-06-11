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

resource "aws_launch_template" "launch_template"{
    name = "${var.type}-launch-template"
    description = "Launch template for ${var.type}"

    image_id = data.aws_ami.ubuntu.image_id

    instance_type = var.instance_type

    vpc_security_group_ids = [var.security_group_id]

    iam_instance_profile {
        name = var.iam_instance_profile_name
    }

    tag_specifications {
        resource_type = "instance"

        tags = {
            Type = var.type
            Name = "${var.type}-instance"
            Owner = var.owner
            Env           = var.env
        }
    }

     tags = {
        Type = var.type
        Name = "${var.type}-instance-template"
        Owner = var.owner
        Env           = var.env
    }

    update_default_version = true

    # For compliance
    # disable_api_stop        = true
    # disable_api_termination = true

    # For hibernation
    hibernation_options {
        configured = var.hibernation_mode
    }
}

resource "aws_instance" "instance"{
    associate_public_ip_address = var.associate_public_ip_address

    launch_template {
      id = aws_launch_template.launch_template.id
    }
}
