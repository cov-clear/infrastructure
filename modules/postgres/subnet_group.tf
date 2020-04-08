resource "aws_db_subnet_group" "main" {
  name_prefix = "sg-${var.identifier}"
  subnet_ids  = var.subnet_ids

  tags = {
    Name = "subnet_group_${var.identifier}"
  }
}