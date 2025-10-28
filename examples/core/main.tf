terraform {
  required_version = ">= 0.12.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.0.0"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
}

module "ses" {
  source = "../../"

  zone_id                      = "Z2CBQCNDG7YEWJA" # Put your Route53 zone ID
  enable_verification          = true
  enable_incoming_email_record = true
}
