provider "aws" {}

resource "aws_instance" "my_first_ec2_instance" {
  ami           = "ami-07ab3281411d31d04"
  instance_type = "t2.micro"
}
