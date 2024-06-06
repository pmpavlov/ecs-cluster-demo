terraform {
  required_version = ">= 1.8.4"
}

provider "aws" {
  region  = var.aws_region
  profile= var.profile
  default_tags {
   tags = {
     Environment = var.environment
     Owner       = var.owner
     Project     = var.project
     Department  = var.department
   }
  }
}

