resource "aws_vpc_security_group_ingress_rule" "mysql_from_source" {
  security_group_id            = var.security_group_id
  referenced_security_group_id = var.source_security_group_id
  from_port                    = 3306
  to_port                      = 3306
  ip_protocol                  = "tcp"
  description                  = "Allow MySQL access from source"
}
