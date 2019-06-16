output "my_static_ip" {
  value = aws_eip.my_static_ip.public_ip
}
