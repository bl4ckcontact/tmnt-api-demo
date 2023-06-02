provider "aws" {
  region                    = var.aws_region
  shared_config_files       = ["~/.aws/config"]
  shared_credentials_files  = ["~/.aws/credentials"]
  profile                   = var.aws_profile
}
terraform {
  required_version = ">= 1.4.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.2.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1.0"
    }
  }

  backend "s3" {
    bucket  = "tmnt-terraform-state"
    key     = "terraform.tfstate"
    region  = "us-west-1"
    encrypt = true
  }
}
