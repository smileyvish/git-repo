terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.10.0"
    }
  }
}

provider "aws"  {
  access_key = "AKIA4A6GABTHW34C4EFM"
  secret_key = "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"
  region = "us-east-1"
}