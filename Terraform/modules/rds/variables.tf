variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "private_db_subnet_ids" {
  type = list(string)
}

variable "db_sg_id" {
  type = string
}

variable "db_engine" {
  type    = string
  default = "postgres"
}

variable "db_engine_version" {
  type    = string
  default = "15"
}

variable "db_instance_class" {
  type    = string
  default = "db.t3.micro" # free-tier friendly; bump for staging/prod
}

variable "allocated_storage" {
  type    = number
  default = 20
}

variable "db_name" {
  type    = string
  default = "appdb"
}

variable "db_username" {
  type    = string
  default = "dbadmin"
}

variable "db_port" {
  type    = number
  default = 5432
}

variable "multi_az" {
  description = "Enable Multi-AZ (recommended for staging/prod, costs more)"
  type        = bool
  default     = false
}

variable "backup_retention_period" {
  type    = number
  default = 7
}
