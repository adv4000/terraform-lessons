#----------------------------------------------------------
# My Terraform
# Provision:
#  - VPC
#  - Internet Gateway

# Made by Denis Astahov. Summer 2020
#----------------------------------------------------------

#==============================================================

data "aws_availability_zones" "available" {}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "${var.env}-vpc"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.env}-igw"
  }
}
