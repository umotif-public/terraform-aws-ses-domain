variable "zone_id" {
  type        = string
  description = "Route53 Zone ID belonging to the desired domain"
}

variable "enable_verification" {
  description = "Control whether or not to verify SES DNS records."
  type        = bool
  default     = true
}

variable "enable_incoming_email_record" {
  description = "Control whether or not to handle incoming emails"
  type        = string
  default     = true
}

variable "enable_spf_record" {
  description = "Control whether or not to set SPF records."
  type        = bool
  default     = true
}

variable "spf_txt_record" {
  description = "DNS TXT record for SPF to tell email providers which servers are allowed to send email from their domains. Variable is portion of the SPF TXT record."
  type        = string
  default     = "v=spf1 include:amazonses.com -all"
}

variable "additional_verification_tokens" {
  type        = list(string)
  description = "List of additional verification SES domain tokens that will added to verfication Route53 record."
  default     = []
}

variable "enable_verification_record" {
  description = "Control whether or not to create route53 DNS record for SES domain verification."
  type        = bool
  default     = true
}

variable "enable_dkim_record" {
  description = "Control whether or not to create route53 DNS record for SES DKIM."
  type        = bool
  default     = true
}

variable "enable_from_domain_record" {
  type        = bool
  description = "Control whether or not to create route53 DNS record for SES mail from domain."
  default     = true
}

variable "additional_mail_from_records" {
  type        = list(string)
  description = "List of additional records to be added to mail_from_domain Route53 record, e.g. \"10 feedback-smtp.us-east-1.amazonses.com\""
  default     = []
}

variable "additional_incoming_email_records" {
  type        = list(string)
  description = "List of additional records to be added to mx_receive Route53 record, e.g. \"10 inbound-smtp.us-east-1.amazonses.com\""
  default     = []
}
