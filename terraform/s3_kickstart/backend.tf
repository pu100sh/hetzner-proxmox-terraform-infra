provider "aws" {
  region  = local.region
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.20.0"
    }
  }
  required_version = ">= 0.14.2"
}

terraform {
  backend "s3" {
    encrypt = true
    region  = "us-east-1"
  }
}
