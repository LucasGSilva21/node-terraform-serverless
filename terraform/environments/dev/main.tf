terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0.0"
    }
  }
  backend "s3" {
    bucket = "dev-cortes-online-terraform-state"
    region = "us-east-1"
    key    = "terraform.tfstate"
  }
}

provider "aws" {
  region = "us-east-1"
}

module "users" {
  source         = "../../infra/users"
  environment    = var.environment
  write_capacity = 1
  read_capacity  = 1
}
