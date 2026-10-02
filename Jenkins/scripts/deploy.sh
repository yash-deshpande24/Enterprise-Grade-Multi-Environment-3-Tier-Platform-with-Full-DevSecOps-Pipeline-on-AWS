#!/bin/bash
set -euo pipefail

AWS_REGION="${AWS_REGION:-ap-south-1}"
AWS_ACCOUNT_ID="${AWS_ACCOUNT_ID:?Set AWS_ACCOUNT_ID env var}"
IMAGE_TAG="${IMAGE_TAG:-latest}"
ECS_CLUSTER="myapp-dev-cluster"
ECS_WEB_SERVICE="myapp-dev-web-svc"
ECS_APP_SERVICE="myapp-dev-app-svc"

ECR_WEB_REPO="${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/myapp-dev-web"
ECR_APP_REPO="${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/myapp-dev-app"

echo ">> Logging in to ECR..."
aws ecr get-login-password --region "${AWS_REGION}" | \
  docker login --username AWS --password-stdin "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"

echo ">> Pushing images..."
docker push "${ECR_WEB_REPO}:${IMAGE_TAG}"
docker push "${ECR_WEB_REPO}:latest"
docker push "${ECR_APP_REPO}:${IMAGE_TAG}"
docker push "${ECR_APP_REPO}:latest"

echo ">> Forcing ECS redeploy..."
aws ecs update-service --cluster "${ECS_CLUSTER}" --service "${ECS_WEB_SERVICE}" \
  --force-new-deployment --region "${AWS_REGION}"
aws ecs update-service --cluster "${ECS_CLUSTER}" --service "${ECS_APP_SERVICE}" \
  --force-new-deployment --region "${AWS_REGION}"

echo ">> Waiting for services to stabilize..."
aws ecs wait services-stable --cluster "${ECS_CLUSTER}" \
  --services "${ECS_WEB_SERVICE}" "${ECS_APP_SERVICE}" --region "${AWS_REGION}"

echo ">> Deploy complete."
