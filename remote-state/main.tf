terraform {
  required_version = ">= 1.1.4"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.3"

      configuration_aliases = [aws.replica]
    }
  }

  backend "s3" {
    bucket         = "cloud-aws-tfstate"
    key            = "terraform.tfstate"
    region         = "eu-central-1"
    encrypt        = true
    kms_key_id     = "alias/tf-remote-state-key"
    dynamodb_table = "tf-remote-state-lock"
  }
}

provider "aws" {
  region = "eu-central-1"
}
