provider "aws" {
  version = ">= 3.8"
  region  = "eu-west-1"
}

module "ses" {
  source = "../../"

  zone_id                      = "Z2CBQCNDG7YEWJA" # Put your Route53 zone ID
  enable_verification          = true
  enable_incoming_email_record = true
}
