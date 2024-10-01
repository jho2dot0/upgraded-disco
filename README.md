# Upgraded Disco Project

This project sets up a scalable web application infrastructure on AWS using Terraform and includes a deployment process using Ansible.

## Project Structure

```
.
├── README.md
├── .github
│   └── workflows
│       └── docker-build-push.yml
├── ansible
│   ├── deploy.yml
│   └── ansiblereadme.md
├── app
│   ├── app.py
│   ├── Dockerfile
│   └── requirements.txt
└── terraform
    ├── alb.tf
    ├── backend.tf
    ├── cloudfront.tf
    ├── ecr.tf
    ├── ecs.tf
    ├── iam.tf
    ├── main.tf
    ├── network.tf
    ├── outputs.tf
    ├── providers.tf
    ├── tfreadme.md
    ├── variables.tf
    └── waf.tf
```

## Prerequisites

Before running the Terraform configuration, you need to set up two IAM users in your AWS account:

1. **terraform-user**: This user will be used to apply the Terraform configuration.

   Create an inline policy for this user with the following JSON:

   ```json
   {
     "Version": "2012-10-17",
     "Statement": [
       {
         "Effect": "Allow",
         "Action": [
           "ec2:*",
           "ecr:*",
           "ecs:*",
           "elasticloadbalancing:*",
           "iam:PassRole",
           "iam:CreateRole",
           "iam:GetRole",
           "iam:ListRolePolicies",
           "iam:ListAttachedRolePolicies",
           "iam:ListInstanceProfilesForRole",
           "iam:DeleteRole",
           "iam:AttachRolePolicy",
           "iam:DetachRolePolicy",
           "iam:TagRole",
           "s3:*",
           "cloudfront:*",
           "wafv2:*",
           "route53:*",
           "logs:*",
           "cloudwatch:*",
           "dynamodb:GetItem",
           "dynamodb:PutItem",
           "dynamodb:DeleteItem"
         ],
         "Resource": "*"
       },
       {
         "Effect": "Allow",
         "Action": [
           "iam:CreateServiceLinkedRole"
         ],
         "Resource": "arn:aws:iam::*:role/aws-service-role/*"
       }
     ]
   }
   ```

2. **ecr-upload**: This user will be used to handle image uploads in the ECR GitHub Action.

   Create an inline policy for this user with the following JSON:

   ```json
   {
     "Version": "2012-10-17",
     "Statement": [
       {
         "Sid": "AllowPushPull",
         "Effect": "Allow",
         "Action": [
           "ecr:BatchGetImage",
           "ecr:BatchCheckLayerAvailability",
           "ecr:CompleteLayerUpload",
           "ecr:GetDownloadUrlForLayer",
           "ecr:InitiateLayerUpload",
           "ecr:PutImage",
           "ecr:UploadLayerPart"
         ],
         "Resource": "arn:aws:ecr:us-east-2:417724558654:repository/upgraded-disco-app"
       },
       {
         "Sid": "GetAuthorizationToken",
         "Effect": "Allow",
         "Action": [
           "ecr:GetAuthorizationToken"
         ],
         "Resource": "*"
       }
     ]
   }
   ```

## Terraform Configuration

The Terraform configuration sets up the following resources:

- VPC and networking components
- ECS Fargate cluster
- Application Load Balancer
- CloudFront distribution
- ECR repository
- IAM roles and policies

To apply the Terraform configuration:

1. Navigate to the `terraform` directory.
2. Initialize Terraform: `terraform init`
3. Plan the changes: `terraform plan`
4. Apply the configuration: `terraform apply`

## GitHub Actions

This project includes a GitHub Action workflow (`ecr.yml`) that automates the process of building the Docker image and pushing it to Amazon ECR. The workflow is triggered on pushes to the main branch or can be manually run.

Key steps in the workflow:

1. Checkout the repository
2. Configure AWS credentials
3. Login to Amazon ECR
4. Build, tag, and push the image to Amazon ECR

To use this workflow, ensure you have set up the following secrets in your GitHub repository:

- `AWS_ACCESS_KEY_ID`: Access key for the ecr-upload IAM user
- `AWS_SECRET_ACCESS_KEY`: Secret key for the ecr-upload IAM user

## Ansible Deployment

The `ansible/deploy.yml` playbook is used to deploy the Docker image from ECR to ECS Fargate. To run the playbook:

```bash
ansible-playbook ansible/deploy.yml \
  -e "ecr_repository_url=<ECR_REPO_URL>" \
  -e "subnet_ids=<SUBNET_IDS>" \
  -e "allow_http_sg_id=<SECURITY_GROUP_ID>" \
  -e "ecs_task_execution_role_arn=<ROLE_ARN>" \
  -e "ecs_task_cpu=256" \
  -e "ecs_task_memory=512" \
  -e "target_group_arn=<TARGET_GROUP_ARN>"
```

## Future Improvements

With more time, the following improvements could be made:

1. **WAF Setup**: Properly configure the Web Application Firewall for enhanced security.
2. **Automated Ansible Deployment**: Create a GitHub Action that uses Terraform output to set up variables for the Ansible playbook, automating the deployment process.
3. **Security Group Refinement**: Tighten up the security groups for better access control.
4. **Terraform Role Assumption**: Set up Terraform to assume roles and use OAuth through GitHub Actions for improved security.
5. **CI/CD Pipeline**: Implement a full CI/CD pipeline using GitHub Actions for automated testing and deployment.
6. **Monitoring and Logging**: Set up comprehensive monitoring and logging solutions.
7. **Cost Optimization**: Implement strategies to optimize AWS resource usage and costs.
8. **Documentation**: Expand documentation to include detailed setup instructions and troubleshooting guides.