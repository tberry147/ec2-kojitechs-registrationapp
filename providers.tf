

terraform {
  required_version = ">=1.1.0"

  backend "s3" {
    bucket = "ops-iandi-network"
    dynamodb_table = "terraform-lock"
    key = "path/env"
    region = "us-east-1"
    encrypt = "true"
  }
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region  = var.region
  profile = "default"

  default_tags {
    tags = local.mandatory_tag
  }

}