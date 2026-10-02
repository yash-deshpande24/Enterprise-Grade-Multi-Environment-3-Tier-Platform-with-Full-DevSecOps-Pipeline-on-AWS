#!/bin/bash
set -euo pipefail

AWS_REGION="${AWS_REGION:-ap-south-1}"
AWS_ACCOUNT_ID="${AWS_ACCOUNT_ID:?Set AWS_ACCOUNT_ID env var}"
IMAGE_TAG="${IMAGE_TAG:-latest}"

ECR_WEB_REPO="${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/myapp-dev-web"
ECR_APP_REPO="${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/myapp-dev-app"

echo ">> Building web image..."
docker build -t "${ECR_WEB_REPO}:${IMAGE_TAG}" -t "${ECR_WEB_REPO}:latest" ./app/web

echo ">> Building app image..."
docker build -t "${ECR_APP_REPO}:${IMAGE_TAG}" -t "${ECR_APP_REPO}:latest" ./app/api

echo ">> Build complete: tag=${IMAGE_TAG}"
