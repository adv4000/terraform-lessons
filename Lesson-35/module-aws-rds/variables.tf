variable "name" {
  description = "A unique identifier for the RDS instance"
  type        = string
}

variable "engine" {
  description = "The name of the database engine to be used for this DB instance"
}

variable "engine_version" {
  description = "The version number of the database engine to use"
}

variable "username" {
  description = "Master username for the database"
}

variable "port" {
  description = "The port on which the DB accepts connections"
}

variable "backup_retention_period" {
  description = "The number of days during which automatic DB snapshots are retained"
  default     = 0
}

variable "storage_encrypted" {
  description = "Specifies whether the DB instance is encrypted"
  default     = true
}

variable "multi_az" {
  description = "Is the RDS MultiAZ or SingleAZ. False for Single AZ and True for MultiAZ"
  default     = false
}

variable "password_length" {
  description = "Length of the randomly generated password"
  default     = 16
}

variable "tags" {
  type    = map(any)
  default = {}
}

variable "environment" {
  description = "The name of the environment"
  type        = string
}

variable "db_cluster_instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
}

variable "storage_type" {
  description = "One of 'standard' (magnetic), 'gp3' (general purpose SSD), or 'io1' (provisioned IOPS SSD). The default is 'io1' if iops is specified, 'standard' if not. Note that this behavior is different from the AWS web console, where the default is 'gp2'."
  type        = string
  default     = "gp3"
}

variable "vpc_id" {
  description = "The ID of the VPC where the RDS Single-AZ/MultiAZ instance will be created"
}

variable "subnet_ids" {
  description = "The IDs of the subnets for the RDS Single-AZ/MultiAZ instance"
  type        = list(string)
}

variable "allocated_storage" {
  description = "Size of the storage"
  default     = 20
}

variable "max_allocated_storage" {
  description = "Enable AutoScaling up to"
  default     = null
}

variable "cidr_blocks" {
  description = "ingress CIDR "
  default     = ["0.0.0.0/0"]
  type        = list(string)
}

variable "db_name" {
  description = "value of the initial database name"
  type        = string
  default     = ""
}
