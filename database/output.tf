output "rds_endpoint" {
  value     = aws_db_instance.db_instance.endpoint
  sensitive = true
}