# Upgraded Disco - Terraform Infrastructure

This repository contains Terraform configurations for deploying a scalable web application infrastructure on AWS. The infrastructure includes ECS Fargate for running containerized applications, an Application Load Balancer (ALB) for traffic distribution, CloudFront for content delivery, and various supporting AWS services.

## Project Structure

The Terraform configuration is split into multiple files for better organization:

- `alb.tf`: Defines the Application Load Balancer and related resources.
- `backend.tf`: Configures the S3 backend for storing Terraform state.
- `cloudfront.tf`: Sets up the CloudFront distribution.
- `ecr.tf`: Creates an Elastic Container Registry (ECR) repository.
- `ecs.tf`: Defines the ECS cluster, task definition, and service.
- `iam.tf`: Sets up IAM roles and policies for ECS tasks.
- `main.tf`: Currently empty, reserved for future use.
- `network.tf`: Configures VPC, subnets, internet gateway, and security groups.
- `outputs.tf`: Defines outputs for important resource information.
- `providers.tf`: Configures the AWS provider and default tags.
- `variables.tf`: Defines input variables for the Terraform configuration.
- `waf.tf`: Contains commented-out WAF configuration (can be enabled if needed).

## Prerequisites

Before you begin, ensure you have the following:

1. **AWS Account**: You need an AWS account with sufficient permissions to create the required resources.

2. **Terraform**: Install Terraform v1.9.6 or later on your local machine.

3. **AWS CLI**: Install the AWS CLI on your local machine.

4. **Terraform IAM User**:

   - Create a new IAM user in your AWS account for Terraform.
   - Attach the following inline policy to the user:

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
           "Action": ["iam:CreateServiceLinkedRole"],
           "Resource": "arn:aws:iam::*:role/aws-service-role/*"
         }
       ]
     }
     ```

   - Generate AWS access keys for this user and configure your AWS CLI with these credentials.

5. **S3 Bucket for Terraform State**:

   - Create an S3 bucket to store the Terraform state:
     ```
     aws s3 mb s3://upgraded-disco-state-bucket --region us-east-2
     ```
   - Enable versioning on the bucket:
     ```
     aws s3api put-bucket-versioning --bucket upgraded-disco-state-bucket --versioning-configuration Status=Enabled
     ```

6. **DynamoDB Table for State Locking**:

   - Create a DynamoDB table for state locking:
     ```
     aws dynamodb create-table \
         --table-name upgraded-disco-state-lock \
         --attribute-definitions AttributeName=LockID,AttributeType=S \
         --key-schema AttributeName=LockID,KeyType=HASH \
         --provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1 \
         --region us-east-2
     ```

7. **Update Backend Configuration**:
   - Ensure the `backend.tf` file correctly references your S3 bucket and DynamoDB table:
     ```hcl
     terraform {
       backend "s3" {
         bucket         = "upgraded-disco-state-bucket"
         key            = "terraform.tfstate"
         region         = "us-east-2"
         encrypt        = true
         dynamodb_table = "upgraded-disco-state-lock"
       }
     }
     ```

## Getting Started

1. Clone this repository:

   ```
   git clone https://github.com/jho2dot0/upgraded-disco.git
   cd upgraded-disco
   ```

2. Initialize Terraform:

   ```
   terraform init
   ```

3. Review and modify the variables in `variables.tf` as needed.

4. Plan the Terraform changes:

   ```
   terraform plan
   ```

5. Apply the Terraform configuration:
   ```
   terraform apply
   ```

## Key Components

- **VPC and Networking**: A VPC with public subnets across two availability zones, internet gateway, and route tables.
- **ECS Cluster**: Fargate cluster for running containerized applications.
- **Application Load Balancer**: Distributes traffic to ECS tasks.
- **CloudFront**: CDN for efficient content delivery.
- **ECR Repository**: For storing Docker images of your application.
- **Security Groups**: Controls inbound and outbound traffic.
- **IAM Roles**: Necessary permissions for ECS tasks.

## Customization

- Modify the `variables.tf` file to adjust resource configurations.
- Update the ECS task definition in `ecs.tf` to match your application requirements.
- Adjust the ALB and target group settings in `alb.tf` if needed.
- Enable and configure WAF in `waf.tf` for additional security (note: additional costs may apply).

## Outputs

After applying the Terraform configuration, you'll receive important information as outputs, including:

- ECR repository URL
- ALB DNS name
- CloudFront distribution domain name
- ECS cluster name
- VPC ID
- Subnet IDs

## Security Considerations

- The current configuration allows HTTP traffic from any source to the ALB. In a production environment, consider limiting this to CloudFront IP ranges only.
- WAF is currently commented out. Consider enabling it for production use to enhance security.
- Ensure that your AWS credentials are kept secure and not committed to version control.

## Cost Management

- Some resources, particularly NAT Gateways and WAF, can incur significant costs. They are either not included or commented out in this configuration.
- Remember to destroy resources when not in use to avoid unnecessary charges:
  ```
  terraform destroy
  ```
