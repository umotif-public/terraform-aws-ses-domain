variable "zone_id" {
  type        = string
  description = "Route53 Zone ID belonging to the desired domain"
}

variable "enable_verification" {
  description = "Control whether or not to verify SES DNS records."
  type        = bool
  default     = true
}

variable "enable_incoming_email" {
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
