provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project = "Upgraded Disco"
      ManagedBy = "Terraform"
      TerraformRepo = "https://github.com/jho2dot0/upgraded-disco"
    }
  }
}
