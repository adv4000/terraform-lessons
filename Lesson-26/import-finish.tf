resource "aws_instance" "node1" {
  ami                    = "ami-0a634ae95e11c6f91"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.nomad.id]
  ebs_optimized          = true
  tags = {
    Name  = "Nomad Ubuntu Node-1"
    Owner = "Denis Astahov"
  }
}

resource "aws_instance" "node2" {
  ami                    = "ami-0a634ae95e11c6f91"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.nomad.id]
  ebs_optimized          = true
  tags = {
    Name  = "Nomad Ubuntu Node-2"
    Owner = "Denis Astahov"
  }
}

resource "aws_instance" "node3" {
  ami                    = "ami-0a634ae95e11c6f91"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.nomad.id]
  ebs_optimized          = true
  tags = {
    Name  = "Nomad Ubuntu Node-3"
    Owner = "Denis Astahov"
  }
}

resource "aws_security_group" "nomad" {
  description = "Nomad"
  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name  = "Nomad Cluster"
    Owner = "Denis Astahov"
  }
}
