provider "aws" {
}

data "aws_ami" "linux"{
    owners = "amazon"

    most_recent = true
    name_regex = "Ubuntu Server"

}

resource "aws_launch_template" "frontend"{
    name = "frontend"

    # For compliance
    # disable_api_stop        = true
    # disable_api_termination = true

    # For hibernation
    hibernation_options {
        configured = true
    }

    description = "Frontend template"

    instance_type = "t3.micro"

    tag_specifications {
        resource_type = "launch-template"

        tags = {
            Type = "frontend"
        }
    }
}