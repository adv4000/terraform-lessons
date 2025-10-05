#----------------------------------------------------------
#  Terraform - From Zero to Certified Professional
#
# New way of Secrets management using Ephemeral block
#
# Made by Denis Astahov
#----------------------------------------------------------
provider "aws" {
  region = "ca-west-1"
}

ephemeral "random_password" "masterdb" { #---> Generate Password
  length           = 16
  special          = true
  override_special = "!$%#"
}

resource "aws_ssm_parameter" "masterdb_password" { #---> Store Password
  name             = "/prod/masterdb/password"
  type             = "SecureString"
  value_wo         = ephemeral.random_password.masterdb.result
  value_wo_version = 1
}

ephemeral "aws_ssm_parameter" "masterdb_password" { #---> Get Password
  arn = aws_ssm_parameter.masterdb_password.arn
}

resource "aws_db_instance" "masterdb" { #---> Use Password
  identifier          = "prod-master-db"
  db_name             = "master"
  allocated_storage   = 20
  instance_class      = "db.t3.micro"
  engine              = "mysql"
  engine_version      = "8.0"
  username            = "admin"
  skip_final_snapshot = true
  password_wo         = ephemeral.aws_ssm_parameter.masterdb_password.value
  password_wo_version = 1
}
