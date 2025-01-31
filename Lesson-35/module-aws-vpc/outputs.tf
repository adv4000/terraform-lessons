output "vpc_id" {
  value = aws_vpc.main.id
}

output "vpc_cidr" {
  value = aws_vpc.main.cidr_block
}

output "igw_id" {
  value = aws_internet_gateway.main.id
}

output "subnet_ids" {
  value = aws_subnet.public_subnets[*].id
}
