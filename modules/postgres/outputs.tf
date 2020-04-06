output "address" {
  value = aws_db_instance.main.address
}

output "arn" {
  value = aws_db_instance.main.arn
}

output "availability_zone" {
  value = aws_db_instance.main.availability_zone
}

output "endpoint" {
  value = aws_db_instance.main.endpoint
}

output "hosted_zone_id" {
  value = aws_db_instance.main.hosted_zone_id
}

output "id" {
  value = aws_db_instance.main.id
}

output "resource_id" {
  value = aws_db_instance.main.resource_id
}

output "status" {
  value = aws_db_instance.main.status
}

output "name" {
  value = aws_db_instance.main.name
}

output "username" {
  value = aws_db_instance.main.username
}

output "password" {
  value = aws_db_instance.main.password
  sensitive = true
}

output "port" {
  value = aws_db_instance.main.port
}