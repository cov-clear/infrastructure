output "connection_url" {
  value = "postgres://${aws_db_instance.main.username}:${aws_db_instance.main.password}@${aws_db_instance.main.endpoint}/${aws_db_instance.main.name}"
}

output "address" {
  value = aws_db_instance.main.address
}

output "endpoint" {
  value = aws_db_instance.main.endpoint
}

output "name" {
  value = aws_db_instance.main.name
}

output "username" {
  value = aws_db_instance.main.username
}

output "password" {
  value     = aws_db_instance.main.password
  sensitive = true
}

output "port" {
  value = aws_db_instance.main.port
}
