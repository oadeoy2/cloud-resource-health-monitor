# backend.tf
terraform {
  backend "s3" {
    bucket         = "cloud-resource-monitor-tf-state"
    key            = "env/dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}