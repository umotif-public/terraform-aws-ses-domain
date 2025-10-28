![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/umotif-public/terraform-aws-ses-domain?style=social)

# terraform-aws-ses-domain

Terraform module to configure a domain hosted on Route53 to work with AWS Simple Email Service (SES). Module supports both single and multi regional deployments.

These types of resources are created:

* TXT record for SPF validation
* Custom TXT record for SPF validation
* Custom MAIL FROM domain
* CNAME records for DKIM verification
* SES Verfication for the domain
* MX record pointing to AWS's SMTP endpoint

## Terraform versions

Terraform 0.12 and 0.13. Pin module version to `~> v2.0`. Submit pull-requests to `master` branch.

## Usage

### Application Load Balancer

```hcl
module "ses-domain" {
  source = "umotif-public/ses-domain/aws"
  version = "~> 2.0.0"

  zone_id               = "Z2CBQCNDG7YEWJA"
  enable_verification   = true
  enable_incoming_email = true
}
```

## Assumptions

Module is to be used with Terraform > 0.12.

## Examples

* [SES Domain- single region](https://github.com/umotif-public/terraform-aws-ses-domain/tree/master/examples/core)
* [SES Domain- multi regional](https://github.com/umotif-public/terraform-aws-ses-domain/tree/master/examples/multi-regional)

## Authors

Module managed by [Marcin Cuber](https://github.com/marcincuber) [LinkedIn](https://www.linkedin.com/in/marcincuber/).

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.41 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 2.41 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_route53_record.amazonses_verification_record](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.mx_receive](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.ses_dkim_record](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.ses_domain_mail_from_mx](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.spf_domain](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.spf_mail_from](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_ses_domain_dkim.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_domain_dkim) | resource |
| [aws_ses_domain_identity.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_domain_identity) | resource |
| [aws_ses_domain_identity_verification.verification](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_domain_identity_verification) | resource |
| [aws_ses_domain_mail_from.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_domain_mail_from) | resource |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_route53_zone.domain](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_incoming_email_records"></a> [additional\_incoming\_email\_records](#input\_additional\_incoming\_email\_records) | List of additional records to be added to mx\_receive Route53 record, e.g. "10 inbound-smtp.us-east-1.amazonses.com" | `list(string)` | `[]` | no |
| <a name="input_additional_mail_from_records"></a> [additional\_mail\_from\_records](#input\_additional\_mail\_from\_records) | List of additional records to be added to mail\_from\_domain Route53 record, e.g. "10 feedback-smtp.us-east-1.amazonses.com" | `list(string)` | `[]` | no |
| <a name="input_additional_verification_tokens"></a> [additional\_verification\_tokens](#input\_additional\_verification\_tokens) | List of additional verification SES domain tokens that will added to verfication Route53 record. | `list(string)` | `[]` | no |
| <a name="input_enable_dkim_record"></a> [enable\_dkim\_record](#input\_enable\_dkim\_record) | Control whether or not to create route53 DNS record for SES DKIM. | `bool` | `true` | no |
| <a name="input_enable_from_domain_record"></a> [enable\_from\_domain\_record](#input\_enable\_from\_domain\_record) | Control whether or not to create route53 DNS record for SES mail from domain. | `bool` | `true` | no |
| <a name="input_enable_incoming_email_record"></a> [enable\_incoming\_email\_record](#input\_enable\_incoming\_email\_record) | Control whether or not to handle incoming emails | `string` | `true` | no |
| <a name="input_enable_spf_record"></a> [enable\_spf\_record](#input\_enable\_spf\_record) | Control whether or not to set SPF records. | `bool` | `true` | no |
| <a name="input_enable_verification"></a> [enable\_verification](#input\_enable\_verification) | Control whether or not to verify SES DNS records. | `bool` | `true` | no |
| <a name="input_enable_verification_record"></a> [enable\_verification\_record](#input\_enable\_verification\_record) | Control whether or not to create route53 DNS record for SES domain verification. | `bool` | `true` | no |
| <a name="input_spf_txt_record"></a> [spf\_txt\_record](#input\_spf\_txt\_record) | DNS TXT record for SPF to tell email providers which servers are allowed to send email from their domains. Variable is portion of the SPF TXT record. | `string` | `"v=spf1 include:amazonses.com -all"` | no |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | Route53 Zone ID belonging to the desired domain | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ses_domain_identity_verification_token"></a> [ses\_domain\_identity\_verification\_token](#output\_ses\_domain\_identity\_verification\_token) | SES domain verification token. |
| <a name="output_ses_identity_arn"></a> [ses\_identity\_arn](#output\_ses\_identity\_arn) | SES identity ARN. |
<!-- END_TF_DOCS -->

## License

See LICENSE for full details.

## Pre-commit hooks

### Install dependencies

* [`pre-commit`](https://pre-commit.com/#install)
* [`terraform-docs`](https://github.com/segmentio/terraform-docs) required for `terraform_docs` hooks.
* [`TFLint`](https://github.com/terraform-linters/tflint) required for `terraform_tflint` hook.

#### MacOS

```bash
brew install pre-commit terraform-docs tflint

brew tap git-chglog/git-chglog
brew install git-chglog
```
