terraform {
  required_version = ">= 1.5.7"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "<= 4.8.0"
    }
  }
}

provider "aws" {
  region  = var.aws_region
//  profile= var.profile
  default_tags {
   tags = {
     Environment = var.environment
     Owner       = var.owner
     Project     = var.project
     Department  = var.department
   }
  }
}

