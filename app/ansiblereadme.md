# Ansible Deployment Playbook

This README provides an overview of the `deploy.yml` Ansible playbook used for deploying Docker images from Amazon Elastic Container Registry (ECR) to Amazon Elastic Container Service (ECS) Fargate.

## Overview

The `deploy.yml` playbook automates the process of updating or creating an ECS service with the latest Docker image from ECR. It handles task definition updates, service creation or updates, and ensures the service reaches a stable state after deployment.

## Prerequisites

Before running this playbook, ensure you have:

1. Ansible installed on your local machine
2. The `community.aws` collection installed (`ansible-galaxy collection install community.aws`)
3. AWS CLI configured with appropriate credentials
4. Terraform output variables available (the playbook uses these for configuration)

## Playbook Structure

The playbook performs the following main tasks:

1. Validates required variables
2. Registers a new ECS task definition
3. Retrieves current ECS service information
4. Updates an existing ECS service or creates a new one
5. Waits for the service to reach a stable state
6. Displays service deployment information

## Usage

To run the playbook:

```bash
ansible-playbook deploy.yml \
  -e "ecr_repository_url=123456789.dkr.ecr.us-east-2.amazonaws.com/upgraded-disco-app" \
  -e "subnet_ids=subnet-1234567a,subnet-1234567b" \
  -e "allow_http_sg_id=sg-1234567" \
  -e "ecs_task_execution_role_arn=arn:aws:iam::123456789:role/ecs-task-execution-role" \
  -e "ecs_task_cpu=256" \
  -e "ecs_task_memory=512" \
  -e "target_group_arn=arn:aws:elasticloadbalancing:us-east-2:123456789:targetgroup/main-tg/1234567890abcdef"
```

Note: You need to provide the Terraform output variables as extra vars. You can also use the Terraform output to set environment variables.

## Variables

The playbook expects the following variables:

- `cluster_name`: Name of the ECS cluster
- `service_name`: Name of the ECS service
- `task_def_name`: Name of the ECS task definition
- `container_name`: Name of the container in the task definition
- `ecr_repository_url`: URL of the ECR repository
- `region`: AWS region
- `subnet_ids`: List of subnet IDs for the ECS tasks
- `allow_http_sg_id`: ID of the security group allowing HTTP traffic
- `ecs_task_execution_role_arn`: ARN of the ECS task execution role
- `ecs_task_cpu`: CPU units for the ECS task
- `ecs_task_memory`: Memory for the ECS task in MiB

These variables should be provided by your Terraform output or set manually if running the playbook independently.

## Important Notes

- The playbook assumes you're using Fargate as the launch type for your ECS tasks.
- It's designed to work with an Application Load Balancer (ALB) setup.
- The playbook will create a new service if it doesn't exist, or update an existing one.
- It waits for the service to stabilize before completing, with a maximum of 30 retries at 10-second intervals.

## Customization

You may need to adjust the playbook based on your specific requirements, such as:
- Changing the container port if your application uses a different port
- Modifying the number of desired tasks
- Adjusting the stabilization wait time

Always test changes in a non-production environment before applying them to production systems.
