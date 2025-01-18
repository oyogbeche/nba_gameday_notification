variable "create_email_identity" {
  description = "Whether to create an email identity."
  type        = bool
  default     = false
}

variable "email_identity" {
  description = "The email identity to configure for SES."
  type        = string
  default     = ""
}
