output "secret_id" {
  value = aws_secretsmanager_secret.secret.arn
}

output "secret_version_id" {
  value = aws_secretsmanager_secret_version.secret_value.version_id
}