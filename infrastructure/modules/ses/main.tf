resource "aws_ses_domain_identity" "domain" {
  domain = var.domain_name
}

resource "aws_ses_domain_dkim" "dkim" {
  domain = aws_ses_domain_identity.domain.domain
}

resource "aws_ses_domain_mail_from" "mail_from" {
  domain      = aws_ses_domain_identity.domain.domain
  mail_from_domain = var.mail_from_domain
  behavior_on_mx_failure = var.behavior_on_mx_failure
}

resource "aws_ses_email_identity" "email" {
  count = var.create_email_identity ? 1 : 0
  email = var.email_identity
}
