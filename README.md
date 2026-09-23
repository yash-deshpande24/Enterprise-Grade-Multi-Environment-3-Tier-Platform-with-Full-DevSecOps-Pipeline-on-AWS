# Enterprise-Grade 3-Tier Platform on AWS | Full DevSecOps Pipeline

Production-grade, multi-environment (dev/staging/prod) 3-tier architecture on AWS with fully automated CI/CD, Infrastructure as Code, container security scanning, and end-to-end observability.

![Architecture Diagram](./architecture-diagram.png)

## Overview

This project provisions and deploys a complete 3-tier web application on AWS using **Terraform** (Infrastructure as Code), **Docker** (containerization), **Jenkins** (CI/CD automation), and **CloudWatch/Datadog** (observability). It follows DevSecOps best practices with automated vulnerability scanning, zero-downtime deployments, and auto-rollback on failure.

## Architecture

- **Web Tier** — Nginx/React frontend, ECS Fargate, public subnet, Auto Scaling
- **App Tier** — Backend API service, ECS Fargate, private subnet, internal ALB
- **Data Tier** — RDS (Multi-AZ), private subnet, Secrets Manager for credentials
- **Networking** — Custom VPC across 3 Availability Zones, public/private/DB subnets, NAT Gateway

## Tech Stack

| Category | Tools |
|---|---|
| Cloud Provider | AWS (VPC, ECS Fargate, ALB, RDS, S3, ECR, Route53, ACM, IAM, Secrets Manager, WAF) |
| IaC | Terraform (modular, remote state via S3 + DynamoDB) |
| Containers | Docker, Amazon ECR |
| CI/CD | Jenkins (declarative pipeline) |
| Security | Trivy/Snyk (image scanning), SonarQube (code quality), GuardDuty |
| Monitoring | Amazon CloudWatch, Datadog (APM + dashboards) |
| Alerting | SNS, Slack/PagerDuty integration |

## Features

- Zero-downtime blue-green deployments via ECS + CodeDeploy
- Automated rollback on failed health checks
- Container vulnerability scanning in CI pipeline (DevSecOps)
- Multi-environment support (dev / staging / prod) via Terraform workspaces
- Full observability: infrastructure metrics, application traces, log aggregation
- Cost optimization: Spot Instances for non-prod, auto-scaling schedules

## CI/CD Pipeline

```
Checkout → Code Quality Scan → Image Vulnerability Scan → Unit/Integration Tests
  → Build & Push to ECR → Terraform Plan (approval gate) → Terraform Apply
  → Blue-Green Deploy → Smoke Tests → Auto-Rollback (on failure) → Notify
```

## Project Structure

```
.
├── terraform/
│   ├── modules/
│   │   ├── vpc/
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   └── outputs.tf
│   │   ├── security-groups/
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   └── outputs.tf
│   │   ├── alb/
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   └── outputs.tf
│   │   ├── ecs/
│   │   │   ├── main.tf
│   │   │   ├── task-definitions.tf
│   │   │   ├── variables.tf
│   │   │   └── outputs.tf
│   │   ├── rds/
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   └── outputs.tf
│   │   ├── iam/
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   └── outputs.tf
│   │   └── monitoring/
│   │       ├── cloudwatch.tf
│   │       ├── datadog.tf
│   │       └── variables.tf
│   │
│   └── environments/
│       ├── dev/
│       │   ├── main.tf
│       │   ├── variables.tf
│       │   ├── terraform.tfvars
│       │   └── backend.tf
│       ├── staging/
│       │   ├── main.tf
│       │   ├── variables.tf
│       │   ├── terraform.tfvars
│       │   └── backend.tf
│       └── prod/
│           ├── main.tf
│           ├── variables.tf
│           ├── terraform.tfvars
│           └── backend.tf
│
├── app/
│   ├── web/
│   │   ├── src/
│   │   ├── Dockerfile
│   │   ├── package.json
│   │   └── nginx.conf
│   └── api/
│       ├── src/
│       ├── Dockerfile
│       ├── requirements.txt / package.json
│       └── tests/
│
├── jenkins/
│   ├── Jenkinsfile
│   └── scripts/
│       ├── build.sh
│       ├── deploy.sh
│       └── rollback.sh
│
├── monitoring/
│   ├── cloudwatch-dashboards/
│   │   └── main-dashboard.json
│   └── datadog-dashboards/
│       └── apm-dashboard.json
│
├── docs/
│   ├── architecture-diagram.png
│   └── runbook.md
│
├── docker-compose.yml
├── .gitignore
└── README.md
```

**Folder purpose:**

| Folder | Purpose |
|---|---|
| `terraform/modules/` | Reusable IaC building blocks (one module per AWS resource group) |
| `terraform/environments/` | Env-specific configs (dev/staging/prod) that call the shared modules |
| `app/web/`, `app/api/` | Application source code + Dockerfiles for each tier |
| `jenkins/` | CI/CD pipeline definition and helper deploy/rollback scripts |
| `monitoring/` | Exported dashboard JSONs for CloudWatch and Datadog |
| `docs/` | Architecture diagram, runbooks, extra documentation |

## Getting Started

```bash
# Clone the repo
git clone <repo-url>
cd <repo-name>

# Initialize Terraform
cd terraform/environments/dev
terraform init
terraform plan
terraform apply

# Build and run locally
docker-compose up --build
```

## Monitoring & Observability

- **CloudWatch**: infrastructure alarms (EC2/ECS/RDS/ALB), log groups per service, dashboards
- **Datadog**: distributed tracing across web → app → db, custom dashboards, anomaly detection, synthetic uptime checks

## Security

- WAF + Shield on ALB
- No hardcoded secrets — AWS Secrets Manager
- Least-privilege IAM roles
- VPC Flow Logs + GuardDuty threat detection
- Container image scanning pre-deployment

## Roadmap

- [ ] Add Kinesis Firehose → S3 → Athena log analytics
- [ ] Multi-region failover
- [ ] Canary deployment strategy

## Author

Built by [Your Name] — [LinkedIn] | [Portfolio]
