resource "aws_db_subnet_group" "main" {
  name       = "pg-${var.identifier}"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "pg-${var.identifier}"
  }
}
