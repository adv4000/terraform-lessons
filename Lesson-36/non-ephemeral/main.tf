#----------------------------------------------------------
#  Terraform - From Zero to Certified Professional
#
# Old way of Secrets management NOT using Ephemeral block
#
# Made by Denis Astahov
#----------------------------------------------------------
provider "aws" {
  region = "ca-west-1"
}

resource "random_password" "masterdb" { #---> Generate Password
  length           = 16
  special          = true
  override_special = "!$%#"
}

resource "aws_ssm_parameter" "masterdb_password" { #---> Store Password
  name  = "/prod/masterdb/password"
  type  = "SecureString"
  value = random_password.masterdb.result
}

data "aws_ssm_parameter" "masterdb_password" { #---> Get Password
  name = aws_ssm_parameter.masterdb_password.name
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
  password            = data.aws_ssm_parameter.masterdb_password.value
}
