resource "aws_vpc_security_group_ingress_rule" "https_ipv4" {
  security_group_id = var.security_group_id
  referenced_security_group_id = var.source_security_group_id
  from_port         = var.backend_port
  to_port           = var.backend_port
  ip_protocol       = "tcp"
  description = "Allow access to backend - ipv4"
}

resource "aws_vpc_security_group_ingress_rule" "https_ipv6" {
  security_group_id = var.security_group_id
  referenced_security_group_id = var.source_security_group_id
  from_port         = var.backend_port
  to_port           = var.backend_port
  ip_protocol       = "tcp"
  description = "Allow access to backend - ipv6"
}

resource "aws_vpc_security_group_egress_rule" "all_ipv4" {
  security_group_id = var.security_group_id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 0
  to_port           = 0
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_egress_rule" "all_ipv6" {
  security_group_id = var.security_group_id
  cidr_ipv6         = "::/0"
  from_port         = 0
  to_port           = 0
  ip_protocol       = "-1"
}
