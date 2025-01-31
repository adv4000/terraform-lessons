
output "rds_instance_endpoint" {
  value = aws_db_instance.this.endpoint
}

output "rds_instance_port" {
  value = aws_db_instance.this.port
}

output "rds_instance_username" {
  value = aws_db_instance.this.username
}

output "rds_instance_password_ssm_arn" {
  value = aws_ssm_parameter.rds_instance_password.arn
}

output "rds_instance_identifier" {
  value = aws_db_instance.this.identifier
}
