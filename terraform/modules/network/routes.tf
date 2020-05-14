resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name              = "${var.short_name}-public"
    KubernetesCluster = var.short_name
  }
}

resource "aws_route_table_association" "public" {
  count = length(var.public_subnets)

  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.publics[count.index].id
}

resource "aws_route_table" "private" {
  count = length(var.private_subnets)

  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.privates[count.index].id
  }

  tags = {
    Name              = "${var.short_name}-private-${substr(var.private_subnets[count.index].availability_zone, -2, 2)}"
    KubernetesCluster = var.short_name
  }
}

resource "aws_route_table_association" "private" {
  count = length(var.private_subnets)

  subnet_id      = aws_subnet.privates[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}

