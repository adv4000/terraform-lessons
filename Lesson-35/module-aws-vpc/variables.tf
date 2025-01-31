variable "tags" {
  type    = map(any)
  default = {}
}

variable "environment" {
  description = "The name of the environment"
  type        = string
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}


variable "subnet_cidrs" {
  default = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]
}
