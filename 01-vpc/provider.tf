terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.10.0"
    }
  }
  backend "s3" {
    bucket         = "terrafrom-backend-nvirginia"
    key            = "vpc_module"
    region         = "us-east-1"
    #dynamodb_table = "terrafrom-backend-nvirginia"
    encrypt        = true
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}