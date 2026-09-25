variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "web_container_port" {
  description = "Port the web tier container listens on"
  type        = number
  default     = 80
}

variable "app_container_port" {
  description = "Port the app tier container listens on"
  type        = number
  default     = 8080
}

variable "db_port" {
  description = "Database port (5432 postgres, 3306 mysql)"
  type        = number
  default     = 5432
}
