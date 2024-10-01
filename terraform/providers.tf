terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.69.0"
    }
  }
  required_version = ">= 1.9.6"
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project       = "Upgraded Disco"
      ManagedBy     = "Terraform"
      TerraformRepo = "https://github.com/jho2dot0/upgraded-disco"
    }
  }
}
