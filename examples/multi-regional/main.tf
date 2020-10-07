provider "aws" {
  version = ">= 3.8"
  region  = "eu-west-1"
}

provider "aws" {
  version = ">= 3.8"

  alias  = "us-east"
  region = "us-east-1"
}

module "ses-eu" {
  source = "../../"

  zone_id                           = "Z2LNH83VWBYSKY1" # Put your Route53 zone ID
  enable_verification               = true
  additional_verification_tokens    = [module.ses-us.ses_domain_identity_verification_token]
  additional_mail_from_records      = ["10 feedback-smtp.us-east-1.amazonses.com"]
  additional_incoming_email_records = ["10 inbound-smtp.us-east-1.amazonaws.com"]
}

module "ses-us" {
  source = "../../"

  providers = {
    aws = aws.us-east
  }

  zone_id                    = "Z2LNH83VWBYSKY1" # Put your Route53 zone ID
  enable_verification        = true
  enable_verification_record = false

  enable_spf_record = false

  enable_from_domain_record    = false
  enable_incoming_email_record = false
}
