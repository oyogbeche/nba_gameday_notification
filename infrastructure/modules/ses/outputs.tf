output "domain_identity_arn" {
  description = "ARN of the SES domain identity."
  value       = aws_ses_domain_identity.domain.arn
}

output "dkim_tokens" {
  description = "DKIM tokens for the SES domain identity."
  value       = aws_ses_domain_dkim.dkim.dkim_tokens
}

output "email_identity_arn" {
  description = "ARN of the SES email identity."
  value       = aws_ses_email_identity.email[0].arn

}
