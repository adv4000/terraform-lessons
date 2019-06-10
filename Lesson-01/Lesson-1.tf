provider "aws" {}


resource "aws_instance" "my_Ubuntu" {
  ami           = "ami-090f10efc254eaf55"
  instance_type = "t3.micro"

  tags = {
    Name    = "My Ubuntu Server"
    Owner   = "Denis Astahov"
    Project = "Terraform Lessons"
  }
}

resource "aws_instance" "my_Amazon" {
  ami           = "ami-03a71cec707bfc3d7"
  instance_type = "t3.small"

  tags = {
    Name    = "My Amazon Server"
    Owner   = "Denis Astahov"
    Project = "Terraform Lessons"
  }
}
