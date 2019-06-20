variable "env" {
  default = "dev"
}

variable "prod_onwer" {
  default = "Denis Astahov"
}

variable "noprod_owner" {
  default = "Dyadya Vasya"
}

variable "ec2_size" {
  default = {
    "prod"    = "t3.medium"
    "dev"     = "t3.micro"
    "staging" = "t2.small"
  }
}

variable "allow_port_list" {
  default = {
    "prod" = ["80", "443"]
    "dev"  = ["80", "443", "8080", "22"]
  }
}
