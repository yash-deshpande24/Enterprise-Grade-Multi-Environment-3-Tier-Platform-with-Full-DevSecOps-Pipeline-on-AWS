variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "private_app_subnet_ids" {
  type = list(string)
}

variable "web_sg_id" {
  type = string
}

variable "app_sg_id" {
  type = string
}

variable "web_target_group_arn" {
  type = string
}

variable "app_target_group_arn" {
  type = string
}

variable "internal_alb_dns_name" {
  type = string
}

variable "ecs_task_execution_role_arn" {
  type = string
}

variable "ecs_task_role_arn" {
  type = string
}

variable "db_secret_arn" {
  type = string
}

variable "web_image" {
  description = "Full ECR image URI for web tier, e.g. <account>.dkr.ecr.<region>.amazonaws.com/myapp-dev-web:latest"
  type        = string
}

variable "app_image" {
  description = "Full ECR image URI for app tier"
  type        = string
}

variable "web_container_port" {
  type    = number
  default = 80
}

variable "app_container_port" {
  type    = number
  default = 8080
}

variable "web_cpu" {
  type    = number
  default = 256
}

variable "web_memory" {
  type    = number
  default = 512
}

variable "app_cpu" {
  type    = number
  default = 256
}

variable "app_memory" {
  type    = number
  default = 512
}

variable "web_desired_count" {
  type    = number
  default = 1
}

variable "web_max_count" {
  type    = number
  default = 3
}

variable "app_desired_count" {
  type    = number
  default = 1
}

variable "app_max_count" {
  type    = number
  default = 3
}
