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

# https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/security-group-rules-reference.html

resource "aws_security_group" "frontend" {
    name = "frontend-security-group"
    description = "Allow only HTTPs from internet"

    vpc_id = var.vpc-id

    tags = {
        Name = "frontend-security-group"
    }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.frontend.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv6" {
  security_group_id = aws_security_group.frontend.id
  cidr_ipv6         = "::/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}