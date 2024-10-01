# Project Checklist

## Repository Setup

- [x] Create a new GitHub repository
- [x] Initialize the repository with a README.md file
- [ ] Add a .gitignore file suitable for Terraform, Python, and Jenkins/Ansible
- [x] Create a directory structure for the project
- [x] Create GHA workflow to run PR checks

## Containerized Python Application

- [ ] Create a simple Python web application that displays "Hello World" using Flask
- [ ] Write a Dockerfile to containerize the application
- [ ] Test the container locally

## Infrastructure as Code (Terraform)

- [ ] Write Terraform code to create AWS infrastructure:
  - [ ] VPC and networking components
  - [ ] ECS cluster
  - [ ] Security groups
  - [ ] IAM roles and policies
- [ ] Implement backend for Terraform state (e.g., S3 bucket)
- [ ] Document variables and outputs
- [ ] Implement best practices for security

## Deployment Pipeline

- [ ] Create Ansible playbooks for deployment
- [ ] Implement steps to deploy both infrastructure and application using GHA

## Documentation

- [ ] Write clear README.md with:
  - [ ] Project overview
  - [ ] Prerequisites
  - [ ] Setup instructions
  - [ ] Usage guide
- [ ] Add inline comments to code for better understanding
- [ ] Create architecture diagram

## Security Considerations

- [ ] Implement least privilege principle in IAM roles
- [ ] Ensure all sensitive data (e.g., AWS credentials) are not hardcoded
- [ ] Configure security groups to allow only necessary inbound/outbound traffic
- [ ] Implement encryption for data at rest and in transit
- [ ] Implement Checkov for static code analysis
- [ ] Consider implementing AWS WAF for web application protection

## Testing

- [ ] Test Terraform code (e.g., with Terratest or manual verification)
- [ ] Test deployment pipeline
- [ ] Verify "Hello World" application is accessible and functioning

## Final Checks

- [ ] Ensure all code is functional
- [ ] Verify code is easy to understand and well-documented
- [ ] Double-check that security best practices are followed
- [ ] Ensure all code is pushed and the repository is accessible

## Optional Enhancements

- [ ] Implement a CI/CD workflow with GitHub Actions
