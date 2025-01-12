variable "sns_topic_name" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "display_name" {
  type = string
}

variable "subscriptions" {
  description = <<EOT
A list of subscriptions for the SNS topic. Each subscription is an object with the following attributes:
  - protocol: The protocol of the subscription (e.g., email, sms, lambda, etc.).
  - endpoint: The endpoint for the subscription (e.g., email address, phone number, etc.).
  - raw_message_delivery: (Optional) Whether raw message delivery is enabled.
EOT
  type = list(object({
    protocol             = string
    endpoint             = string
    raw_message_delivery = optional(bool, false)
  }))
  default = []
}

variable "email" {
  type = string
}

variable "phone_number" {
  type = string
}

variable "function_name" {
  type = string
}

variable "iam_policy" {
  type = string
}

variable "runtime" {
  type = string
}

variable "lambda_source_path" {
  type = string
}

variable "zip_output_path" {
  type = string
}

variable "lambda_handler" {
  type = string
}

variable "environment_variables" {
  type = map(string)
}

variable "rule_name" {
  type = string
}

variable "schedule_expression" {
  type = string
}

variable "lambda_permissions" {
  type = list(object({
    function_name = string
  }))
}

variable "targets" {
  type = list(object({
    arn = string
  }))
}
