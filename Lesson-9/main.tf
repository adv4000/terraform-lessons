#----------------------------------------------------------
# My Terraform
#
# Copyleft(c) by Denis Astahov
#----------------------------------------------------------

provider "aws" {}


data "aws_availability_zones" "working" {}
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}


data "aws_vpc" "my_prod_vpc" {
  tags = {
    Name = "prod"
  }
}



resource "aws_subnet" "subnet1" {

  vpc_id            = data.aws_vpc.my_prod_vpc.id
  availability_zone = data.aws_availability_zones.working.names[0]
  cidr_block        = "10.10.1.0/24"
  tags = {
    Name    = "Subnet-1 in ${data.aws_availability_zones.working.names[0]}"
    Account = data.aws_caller_identity.current.account_id
  }
}

resource "aws_subnet" "subnet2" {

  vpc_id            = data.aws_vpc.my_prod_vpc.id
  availability_zone = data.aws_availability_zones.working.names[1]
  cidr_block        = "10.10.2.0/24"
  tags = {
    Name    = "Subnet-2 in ${data.aws_availability_zones.working.names[1]}"
    Account = data.aws_caller_identity.current.account_id
  }
}





output "aws_account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "aws_availability_zones" {
  value = data.aws_availability_zones.working.names
}

output "aws_region_name" {
  value = data.aws_region.current.name
}

output "aws_region_description" {
  value = data.aws_region.current.description
}

output "prod_vpc_id" {
  value = data.aws_vpc.my_prod_vpc.id
}

output "prod_vpc_cidr" {
  value = data.aws_vpc.my_prod_vpc.cidr_block
}
