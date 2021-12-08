terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      configuration_aliases = [
        aws.root,
        aws.prod,
        aws.dev
      ]
    }
  }
}
#----------------------------------------------
data "aws_ami" "latest_ubuntu20_root" {
  provider    = aws.root
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

data "aws_ami" "latest_ubuntu20_prod" {
  provider    = aws.prod
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

data "aws_ami" "latest_ubuntu20_dev" {
  provider    = aws.dev
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}


#-------------------------------------------------------------------
resource "aws_instance" "server_root" {
  provider      = aws.root
  ami           = data.aws_ami.latest_ubuntu20_root.id
  instance_type = var.instance_type
  tags          = { Name = "Server-ROOT" }
}

resource "aws_instance" "server_prod" {
  provider      = aws.prod
  ami           = data.aws_ami.latest_ubuntu20_prod.id
  instance_type = var.instance_type
  tags          = { Name = "Server-PROD" }
}

resource "aws_instance" "server_dev" {
  provider      = aws.dev
  ami           = data.aws_ami.latest_ubuntu20_dev.id
  instance_type = var.instance_type
  tags          = { Name = "Server-DEV" }
}
