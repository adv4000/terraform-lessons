data "aws_availability_zones" "available" {}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "${var.environment}-vpc"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.environment}-igw"
  }
}


resource "aws_subnet" "public_subnets" {
  count                   = length(var.subnet_cidrs)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(var.subnet_cidrs, count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.environment}-public-${count.index + 1}"
  }
}

resource "aws_route_table" "public_subnets" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
  tags = {
    Name = "${var.environment}-route-public-subnets"
  }
}

resource "aws_route_table_association" "public_routes" {
  count          = length(aws_subnet.public_subnets[*].id)
  route_table_id = aws_route_table.public_subnets.id
  subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
}
