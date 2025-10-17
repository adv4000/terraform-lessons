variable "tags" {
  description = "Tags to apply to Resources"
  default = {
    Owner   = "Denis Astahov"
    Company = "ADV-IT"
    Corp    = "ANDESA Soft International"
  }
}

variable "name" {
  description = "Name to use for Resources"
  default     = "My-LambdaFunction"
}
