#!/bin/bash

CLUSTER_NAME="my-cluster"
SERVICE_NAME="my-ecs-service"

# Get the ARN of the currently running task
RUNNING_TASK_ARN=$(aws ecs describe-services --cluster $CLUSTER_NAME --services $SERVICE_NAME --query "services[0].deployments[?status=='ACTIVE'].taskDefinition" --output text)

if [ -n "$RUNNING_TASK_ARN" ]; then
    echo "Running task ARN: $RUNNING_TASK_ARN"
else
    echo "No running task found for service $SERVICE_NAME in cluster $CLUSTER_NAME"
fi

