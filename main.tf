#####
# Domain Verification
#####

resource "aws_ses_domain_identity" "main" {
  domain = data.aws_route53_zone.domain.name
}

resource "aws_ses_domain_identity_verification" "verification" {
  count = var.enable_verification ? 1 : 0

  domain     = aws_ses_domain_identity.main.id
  depends_on = [aws_route53_record.amazonses_verification_record]
}

resource "aws_route53_record" "amazonses_verification_record" {
  zone_id = var.zone_id
  name    = "_amazonses.${aws_ses_domain_identity.main.domain}"
  type    = "TXT"
  ttl     = "600"
  records = [aws_ses_domain_identity.main.verification_token]
}

#####
# MAIL FROM Domain
#####

resource "aws_ses_domain_mail_from" "main" {
  domain           = aws_ses_domain_identity.main.domain
  mail_from_domain = "bounce.${aws_ses_domain_identity.main.domain}"
}

resource "aws_route53_record" "spf_mail_from" {
  zone_id = var.zone_id
  name    = aws_ses_domain_mail_from.main.mail_from_domain
  type    = "TXT"
  ttl     = "600"
  records = ["${var.spf_txt_record}"]
}

resource "aws_route53_record" "spf_domain" {
  count = var.enable_spf_record ? 1 : 0

  zone_id = var.zone_id
  name    = data.aws_route53_zone.domain.name
  type    = "TXT"
  ttl     = "600"
  records = ["${var.spf_txt_record}"]
}

resource "aws_route53_record" "ses_domain_mail_from_mx" {
  zone_id = var.zone_id
  name    = aws_ses_domain_mail_from.main.mail_from_domain
  type    = "MX"
  ttl     = "600"
  records = ["10 feedback-smtp.${data.aws_region.current.name}.amazonses.com"]
}

resource "aws_route53_record" "mx_receive" {
  count = var.enable_incoming_email ? 1 : 0

  name    = data.aws_route53_zone.domain.name
  zone_id = var.zone_id
  type    = "MX"
  ttl     = "600"
  records = ["10 inbound-smtp.${data.aws_region.current.name}.amazonaws.com"]
}


#####
# DKIM Verification
#####

resource "aws_ses_domain_dkim" "main" {
  domain = aws_ses_domain_identity.main.domain
}

resource "aws_route53_record" "ses_dkim_record" {
  count   = 3
  zone_id = var.zone_id
  name    = "${element(aws_ses_domain_dkim.main.dkim_tokens, count.index)}._domainkey.${aws_ses_domain_identity.main.domain}"
  type    = "CNAME"
  ttl     = "600"
  records = ["${element(aws_ses_domain_dkim.main.dkim_tokens, count.index)}.dkim.amazonses.com"]
}
