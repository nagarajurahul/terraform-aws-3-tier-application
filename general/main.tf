terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
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

resource "aws_launch_template" "launch_template"{
    name = "${var.type}-launch-template"
    description = "Launch template for ${var.type}"

    image_id = data.aws_ami.ubuntu.image_id

    instance_type = var.instance_type

    vpc_security_group_ids = [aws_security_group.frontend.id]

    tag_specifications {
        resource_type = "instance"

        tags = {
            Type = type
            Name = "${var.type}-instance"
        }
    }

     tags = {
        TemplateOwner = var.owner
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
    associate_public_ip_address = true

    launch_template {
      id = aws_launch_template.launch_template.id
    }
}

# https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/security-group-rules-reference.html

resource "aws_security_group" "security_group" {
    name = "${var.type}-security-group"
    description = "Security group for ${var.type}"

    vpc_id = var.vpc_id

    tags = {
        Name = "${var.type}-security-group"
    }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv6" {
  security_group_id = aws_security_group.security_group.id
  cidr_ipv6         = "::/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_egress_rule" "allow_all_ipv4" {
  security_group_id = aws_security_group.security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 0
  to_port           = 0
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_egress_rule" "allow_all_ipv6" {
  security_group_id = aws_security_group.security_group.id
  cidr_ipv6         = "::/0"
  from_port         = 0
  to_port           = 0
  ip_protocol       = "-1"
}