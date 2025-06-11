resource "aws_secretsmanager_secret" "secret" {
  name        = "${var.env}/${var.name}"
  description = "Credentials for ${var.env}/${var.name}"

  tags = {
    Env = var.env
    Owner = var.owner
  }
}

resource "aws_secretsmanager_secret_version" "secret_value" {
  secret_id     = aws_secretsmanager_secret.secret.id
  secret_string = jsonencode({
    username = var.username
    password = var.password
  })
}
