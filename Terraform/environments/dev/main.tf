terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

##############################################
# VPC
##############################################
module "vpc" {
  source       = "../../modules/vpc"
  project_name = "myapp"
  environment  = "dev"
  azs          = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
}

##############################################
# Security Groups
##############################################
module "security_groups" {
  source       = "../../modules/security-groups"
  project_name = "myapp"
  environment  = "dev"
  vpc_id       = module.vpc.vpc_id
}

##############################################
# ALB (public + internal)
##############################################
module "alb" {
  source                  = "../../modules/alb"
  project_name            = "myapp"
  environment              = "dev"
  vpc_id                   = module.vpc.vpc_id
  public_subnet_ids        = module.vpc.public_subnet_ids
  private_app_subnet_ids   = module.vpc.private_app_subnet_ids
  alb_sg_id                = module.security_groups.alb_sg_id
  internal_alb_sg_id       = module.security_groups.internal_alb_sg_id
}

##############################################
# RDS
##############################################
module "rds" {
  source                  = "../../modules/rds"
  project_name            = "myapp"
  environment              = "dev"
  private_db_subnet_ids    = module.vpc.private_db_subnet_ids
  db_sg_id                 = module.security_groups.db_sg_id
  multi_az                 = false # keep false for dev to save cost
  backup_retention_period  = 1     # free tier allows max 1 day
}

##############################################
# ECR
##############################################
module "ecr" {
  source       = "../../modules/ecr"
  project_name = "myapp"
  environment  = "dev"
}

##############################################
# IAM (ECS roles)
##############################################
module "iam" {
  source        = "../../modules/iam"
  project_name  = "myapp"
  environment   = "dev"
  db_secret_arn = module.rds.secret_arn
}

##############################################
# ECS (Fargate cluster, web + app services)
##############################################
module "ecs" {
  source                       = "../../modules/ecs"
  project_name                 = "myapp"
  environment                  = "dev"
  aws_region                   = "ap-south-1"
  private_app_subnet_ids       = module.vpc.private_app_subnet_ids
  web_sg_id                    = module.security_groups.web_sg_id
  app_sg_id                    = module.security_groups.app_sg_id
  web_target_group_arn         = module.alb.web_target_group_arn
  app_target_group_arn         = module.alb.app_target_group_arn
  internal_alb_dns_name        = module.alb.internal_alb_dns_name
  ecs_task_execution_role_arn  = module.iam.ecs_task_execution_role_arn
  ecs_task_role_arn            = module.iam.ecs_task_role_arn
  db_secret_arn                = module.rds.secret_arn

  # Placeholder images until you build & push real ones via Jenkins/ECR
  web_image = "${module.ecr.web_repo_url}:latest"
  app_image = "${module.ecr.app_repo_url}:latest"
}
