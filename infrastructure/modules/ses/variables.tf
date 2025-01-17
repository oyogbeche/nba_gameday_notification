variable "domain_name" {
  description = "The domain to configure for SES."
  type        = string
}

variable "mail_from_domain" {
  description = "The subdomain to use as the MAIL FROM domain."
  type        = string
}

variable "behavior_on_mx_failure" {
  description = "Action to take if the required MX record isn't set up."
  type        = string
  default     = "UseDefaultValue"
}

variable "zone_id" {
  description = "Route53 hosted zone ID for the domain."
  type        = string
}

variable "create_verification_records" {
  description = "Whether to create Route53 records for verification."
  type        = bool
  default     = true
}

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
