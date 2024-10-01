terraform {
  backend "s3" {
    bucket         = "upgraded-disco-state-bucket"
    key            = "terraform.tfstate"
    region         = "us-east-2"
    encrypt        = true
    dynamodb_table = "upgraded-disco-state-lock"
  }
}
