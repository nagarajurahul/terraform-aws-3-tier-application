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

    # For compliance
    # disable_api_stop        = true
    # disable_api_termination = true

    # For hibernation
    hibernation_options {
        configured = true
    }

    image_id = data.aws_ami.ubuntu.image_id

    # Free tier
    instance_type = "t2.micro"

    tag_specifications {
        resource_type = "launch-template"

        tags = {
            Type = "frontend"
        }
    }
}