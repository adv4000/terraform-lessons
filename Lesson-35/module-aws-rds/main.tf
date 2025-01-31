resource "aws_db_instance" "this" {
  identifier              = "${var.environment}-${var.name}"
  allocated_storage       = var.allocated_storage
  max_allocated_storage   = var.max_allocated_storage
  engine                  = var.engine
  engine_version          = var.engine_version
  instance_class          = var.db_cluster_instance_class
  storage_type            = var.storage_type
  username                = var.username
  password                = random_password.rds_password.result
  skip_final_snapshot     = true
  copy_tags_to_snapshot   = true
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  db_subnet_group_name    = aws_db_subnet_group.rds_subnet_group.name
  port                    = var.port
  backup_retention_period = var.backup_retention_period
  storage_encrypted       = var.storage_encrypted
  multi_az                = var.multi_az
  db_name                 = var.db_name
  tags                    = var.tags
}

resource "random_password" "rds_password" {
  length  = var.password_length
  special = false
  upper   = true
  lower   = true
  numeric = true
}

resource "aws_security_group" "rds_sg" {
  name        = "${var.environment}-${var.name}-rds-sg"
  vpc_id      = var.vpc_id
  description = "Security group for RDS instance"

  ingress {
    from_port   = var.port
    to_port     = var.port
    protocol    = "tcp"
    cidr_blocks = var.cidr_blocks
  }

  tags = merge(var.tags, { "Name" = "${var.environment}-${var.name}-rds-sg" })
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "${var.environment}-${var.name}-subnet-group"
  subnet_ids = var.subnet_ids
  tags       = var.tags
  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_ssm_parameter" "rds_instance_host" {
  name  = "/${var.environment}/rds/${var.name}/db_host"
  type  = "String"
  value = aws_db_instance.this.address
  tags  = var.tags
}

resource "aws_ssm_parameter" "rds_instance_port" {
  name  = "/${var.environment}/rds/${var.name}/db_port"
  type  = "String"
  value = aws_db_instance.this.port
  tags  = var.tags
}

resource "aws_ssm_parameter" "rds_instance_username" {
  name  = "/${var.environment}/rds/${var.name}/db_username"
  type  = "String"
  value = aws_db_instance.this.username
  tags  = var.tags
}

resource "aws_ssm_parameter" "rds_instance_password" {
  name  = "/${var.environment}/rds/${var.name}/db_password"
  type  = "SecureString"
  value = random_password.rds_password.result
  tags  = var.tags
}
