resource "aws_db_instance" "main" {
  identifier = var.identifier

  engine         = "postgres"
  engine_version = var.engine_version

  instance_class    = var.instance_class
  allocated_storage = var.allocated_storage
  storage_type      = "gp2"
  storage_encrypted = var.storage_encrypted

  name     = var.db_name
  username = var.db_user
  password = var.db_password

  multi_az = var.multi_az
  db_subnet_group_name = aws_db_subnet_group.main.name
  parameter_group_name = aws_db_parameter_group.main.name

  maintenance_window      = var.maintenance_window
  backup_retention_period = var.backup_retention_period
  backup_window           = var.backup_window

  deletion_protection = var.deletion_protection

  tags = {
    Name = var.identifier
  }

  lifecycle {
    ignore_changes = [password]
  }
}
