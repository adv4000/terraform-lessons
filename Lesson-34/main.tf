#----------------------------------------------------------
# Build EC2 Instace using AWS Provider VS AWSCC Provider
#
# Made by Denis Astahov
#----------------------------------------------------------
provider "aws" {
  region = "us-west-2"
}

provider "awscc" {
  region = "us-west-2"
}

variable "tags" {
  description = "Tags to apply"
  type        = map(any)
  default = {
    Owner   = "Denis Astahov"
    Project = "Phoenix"
  }
}


# Reformat Tags from MAP(ANY) to List of MAPS
locals {
  awscc_reformat_tags = [
    for tagKey, tagValue in var.tags :
    {
      key   = tagKey
      value = tagValue
    }
  ]
}

# Create EC2 Instance using AWS Provider
resource "aws_instance" "my_ubuntu" {
  ami           = "ami-06e54d05255faf8f6"
  instance_type = "t3.micro"
  tags = merge(
    {
      Name = "Server-created-by-AWS-Provider"
    },
  var.tags)
}

# Create EC2 Instance using AWSCC Provider
resource "awscc_ec2_instance" "my_ubuntu" {
  image_id      = "ami-06e54d05255faf8f6"
  instance_type = "t3.micro"
  tags = concat(
    [
      {
        key   = "Name",
        value = "Server-created-by-AWSCC-Provider"
      }
    ],
  local.awscc_reformat_tags)
}
