module "vpc" {
  source = "../../module-aws-vpc"

  environment = "dev"
  vpc_cidr    = "10.10.0.0/16"
  subnet_cidrs = [
    "10.10.1.0/24",
    "10.10.2.0/24"
  ]
}

module "database" {
  source = "../../module-aws-rds"

  environment               = "dev"
  name                      = "astahov-db"
  engine                    = "mysql"
  engine_version            = "8.4"
  db_cluster_instance_class = "db.t3.micro"
  db_name                   = "mydatabase"
  username                  = "dbadmin"
  multi_az                  = false
  allocated_storage         = 20
  port                      = 1433
  vpc_id                    = module.vpc.vpc_id
  subnet_ids                = module.vpc.subnet_ids
  cidr_blocks               = [module.vpc.vpc_cidr]
  tags = {
    ProjectCode = "5674848"
  }
}
