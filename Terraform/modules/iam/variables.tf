variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "db_secret_arn" {
  description = "Secrets Manager ARN for DB credentials, so task execution role can read it"
  type        = string
}
