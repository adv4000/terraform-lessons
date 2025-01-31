module "vpc" {
  source = "../../module-aws-vpc"

  environment = "prod"
  vpc_cidr    = "10.20.0.0/16"
  subnet_cidrs = [
    "10.20.1.0/24",
    "10.20.2.0/24"
  ]
}

module "database" {
  source = "../../module-aws-rds"

  environment               = "prod"
  name                      = "astahov-db"
  engine                    = "mysql"
  engine_version            = "8.4"
  db_cluster_instance_class = "db.t3.small"
  db_name                   = "mydatabase"
  username                  = "dbadmin"
  multi_az                  = true
  allocated_storage         = 20
  port                      = 1433
  vpc_id                    = module.vpc.vpc_id
  subnet_ids                = module.vpc.subnet_ids
  cidr_blocks               = [module.vpc.vpc_cidr]
}
