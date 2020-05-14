resource "aws_db_parameter_group" "main" {
  name        = "pg-${var.identifier}"
  description = "Database parameter group for ${var.identifier}"
  family      = var.engine_family

  parameter {
    apply_method = "immediate"
    name         = "autovacuum"
    value        = 1
  }

  tags = {
    "Name" = "pg-${var.identifier}"
  }

  lifecycle {
    create_before_destroy = true
  }
}
