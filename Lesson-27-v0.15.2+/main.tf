# Since Terraform v0.15.2
# terraform apply -replace aws_instance.node2
#
provider "aws" {
  region = "us-west-1"
}

resource "aws_instance" "node1" {
  ami           = "ami-05655c267c89566dd"
  instance_type = "t3.micro"
  tags = {
    Name  = "Node-1"
    Owner = "Denis Astahov"
  }
}

resource "aws_instance" "node2" {
  ami           = "ami-05655c267c89566dd"
  instance_type = "t3.micro"
  tags = {
    Name  = "Node-2"
    Owner = "Denis Astahov"
  }
}

resource "aws_instance" "node3" {
  ami           = "ami-05655c267c89566dd"
  instance_type = "t3.micro"
  tags = {
    Name  = "Node-3"
    Owner = "Denis Astahov"
  }
  depends_on = [aws_instance.node2]
}
