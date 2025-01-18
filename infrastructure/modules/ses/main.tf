resource "aws_ses_email_identity" "email" {
  count = var.create_email_identity ? 1 : 0
  email = var.email_identity
}
