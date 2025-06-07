resource "aws_iam_instance_profile" "iam_instance_profile" {
  name = "${var.type}-iam-instance-profile"
  role = aws_iam_role.role.name
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "role" {
  name               = "${var.type}-role"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}