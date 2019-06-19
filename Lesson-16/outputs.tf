output "rds_password" {
  value = data.aws_ssm_parameter.my_rds_password.value
}
