#----------------------------------------------------------
# My Terraform
#
# Build WebServer during Bootstrap
#
# Made by Denis Astahov
#----------------------------------------------------------


provider "aws" {
  region = "ca-central-1"
}

resource "aws_default_vpc" "default" {} # This need to be added since AWS Provider v4.29+ to get VPC id

resource "aws_eip" "my_static_ip" {
  instance = aws_instance.my_webserver.id
  domain   = "vpc" # Need to add in new AWS Provider version
  tags = {
    Name  = "Web Server IP"
    Owner = "Denis Astahov"
  }
}


resource "aws_instance" "my_webserver" {
  ami                    = "ami-07ab3281411d31d04"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.my_webserver.id]
  user_data = templatefile("user_data.sh.tpl", {
    f_name = "Denis",
    l_name = "Astahov",
    names  = ["Vasya", "Kolya", "Petya", "John", "Donald", "Masha", "Lena", "Katya"]
  })
  user_data_replace_on_change = true # Added in the new AWS provider!!!

  tags = {
    Name  = "Web Server Build by Terraform"
    Owner = "Denis Astahov"
  }

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_security_group" "my_webserver" {
  name        = "WebServer Security Group"
  description = "My First SecurityGroup"
  vpc_id      = aws_default_vpc.default.id # This need to be added since AWS Provider v4.29+ to set VPC id

  dynamic "ingress" {
    for_each = ["80", "443"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "Web Server SecurityGroup"
    Owner = "Denis Astahov"
  }
}
