variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "private_app_subnet_ids" {
  type = list(string)
}

variable "alb_sg_id" {
  type = string
}

variable "internal_alb_sg_id" {
  type = string
}

variable "web_container_port" {
  type    = number
  default = 80
}

variable "app_container_port" {
  type    = number
  default = 8080
}

# variable "acm_certificate_arn" {
#   type = string
# }
