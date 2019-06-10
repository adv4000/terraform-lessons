output "my_web_site_ip" {
  description = "Elatic IP address assigned to our WebSite"
  value       = aws_eip.my_static_ip.public_ip
}

output "my_instance_id" {
  description = "InstanceID of our WebSite"
  value       = aws_instance.my_webserver.id
}

output "my_instance_arn" {
  description = "InstanceARN of our WebSite"
  value       = aws_instance.my_webserver.arn
}

output "my_sg_id" {
  description = "SecurityGroup of our WebSite"
  value       = aws_security_group.my_webserver.id
}
