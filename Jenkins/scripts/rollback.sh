#!/bin/bash
set -euo pipefail

# Usage: ./rollback.sh <web_task_def_revision> <app_task_def_revision>
# Example: ./rollback.sh myapp-dev-web:3 myapp-dev-app:3

AWS_REGION="${AWS_REGION:-ap-south-1}"
ECS_CLUSTER="myapp-dev-cluster"
ECS_WEB_SERVICE="myapp-dev-web-svc"
ECS_APP_SERVICE="myapp-dev-app-svc"

WEB_TASK_DEF="${1:?Pass web task definition revision, e.g. myapp-dev-web:3}"
APP_TASK_DEF="${2:?Pass app task definition revision, e.g. myapp-dev-app:3}"

echo ">> Rolling back web service to ${WEB_TASK_DEF}..."
aws ecs update-service --cluster "${ECS_CLUSTER}" --service "${ECS_WEB_SERVICE}" \
  --task-definition "${WEB_TASK_DEF}" --region "${AWS_REGION}"

echo ">> Rolling back app service to ${APP_TASK_DEF}..."
aws ecs update-service --cluster "${ECS_CLUSTER}" --service "${ECS_APP_SERVICE}" \
  --task-definition "${APP_TASK_DEF}" --region "${AWS_REGION}"

echo ">> Waiting for rollback to stabilize..."
aws ecs wait services-stable --cluster "${ECS_CLUSTER}" \
  --services "${ECS_WEB_SERVICE}" "${ECS_APP_SERVICE}" --region "${AWS_REGION}"

echo ">> Rollback complete."
