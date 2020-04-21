resource "aws_vpc" "main" {
  cidr_block           = var.cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name              = var.short_name
    KubernetesCluster = var.short_name
  }
}

resource "aws_subnet" "privates" {
  count = length(var.private_subnets)

  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnets[count.index].cidr
  availability_zone = var.private_subnets[count.index].availability_zone

  tags = {
    Name                                      = "${var.short_name}-private-${substr(var.public_subnets[count.index].availability_zone, -2, 2)}"
    KubernetesCluster                         = var.short_name
    "kubernetes.io/role/internal-elb"         = "1"
    "kubernetes.io/cluster/${var.short_name}" = "shared"
  }
}

resource "aws_subnet" "publics" {
  count = length(var.public_subnets)

  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnets[count.index].cidr
  availability_zone       = var.public_subnets[count.index].availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name                                      = "${var.short_name}-public-${substr(var.public_subnets[count.index].availability_zone, -2, 2)}"
    KubernetesCluster                         = var.short_name
    "kubernetes.io/role/elb"                  = "1"
    "kubernetes.io/cluster/${var.short_name}" = "shared"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name              = var.short_name
    KubernetesCluster = var.short_name
  }
}

resource "aws_eip" "publics" {
  count = length(var.public_subnets)

  vpc = true

  tags = {
    Name              = "${var.short_name}-nat-${substr(var.public_subnets[count.index].availability_zone, -2, 2)}"
    KubernetesCluster = var.short_name
  }
}

resource "aws_nat_gateway" "privates" {
  count = length(var.public_subnets)

  allocation_id = aws_eip.publics[count.index].id
  subnet_id     = aws_subnet.publics[count.index].id

  tags = {
    Name              = "${var.short_name}-nat-${substr(var.public_subnets[count.index].availability_zone, -2, 2)}"
    KubernetesCluster = var.short_name
  }
}

resource "aws_vpc_dhcp_options" "main" {
  domain_name         = "${var.aws_region}.compute.internal"
  domain_name_servers = ["AmazonProvidedDNS"]

  tags = {
    Name              = var.short_name
    KubernetesCluster = var.short_name
  }
}

resource "aws_vpc_dhcp_options_association" "main" {
  vpc_id          = aws_vpc.main.id
  dhcp_options_id = aws_vpc_dhcp_options.main.id
}
