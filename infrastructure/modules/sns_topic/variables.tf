# modules/sns_topic/variables.tf

variable "name" {
  description = "The name of the SNS topic."
  type        = string
}

variable "display_name" {
  description = "The display name to use for the SNS topic in notifications."
  type        = string
  default     = null
}

variable "fifo_topic" {
  description = "Whether to create a FIFO (first-in-first-out) SNS topic."
  type        = bool
  default     = false
}

variable "content_based_deduplication" {
  description = "Enable content-based deduplication for FIFO topics."
  type        = bool
  default     = false
}

variable "kms_master_key_id" {
  description = "The ID of an AWS-managed customer master key (CMK) for encrypting messages."
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags to assign to the SNS topic."
  type        = map(string)
  default     = {}
}

variable "enable_policy" {
  description = "Whether to attach a policy to the SNS topic."
  type        = bool
  default     = false
}

variable "policy" {
  description = "The JSON policy to attach to the SNS topic."
  type        = string
  default     = ""
}

variable "raw_message_delivery" {
  description = "whether to send raw message or attach metadata"
  type = bool
  default = false
}

variable "email" {
  description = "The email address to subscribe to the SNS topic."
  type        = string
  default     = ""
}

variable "phone_number" {
  description = "The phone number to subscribe to the SNS topic."
  type        = string
  default     = ""
}