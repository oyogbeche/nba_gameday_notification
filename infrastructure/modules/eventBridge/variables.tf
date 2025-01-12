# modules/eventbridge/variables.tf

variable "rule_name" {
  description = "The name of the EventBridge rule."
  type        = string
}

variable "description" {
  description = "The description of the EventBridge rule."
  type        = string
  default     = null
}

variable "event_bus_name" {
  description = "The name of the EventBridge bus."
  type        = string
  default     = "default"
}

variable "event_pattern" {
  description = "The event pattern for the EventBridge rule."
  type        = string
  default     = null
}

variable "schedule_expression" {
  description = "The schedule expression for the EventBridge rule (e.g., cron or rate)."
  type        = string
  default     = null
}

variable "targets" {
  description = <<EOT
A list of targets for the EventBridge rule. 
Each target is an object with the following attributes:
  - arn: The ARN of the target.
  - input: (Optional) JSON input to the target.
  - input_path: (Optional) JSONPath to extract input from the matched event.
  - input_transformer: (Optional) An input transformer block.
EOT
  type = list(object({
    arn              = string
    input            = optional(string, null)
    input_path       = optional(string, null)
    input_transformer = optional(map(string), null)
  }))
  default = []
}

variable "lambda_permissions" {
  description = <<EOT
A list of Lambda permissions to allow EventBridge to invoke the Lambda function. 
Each permission is an object with the following attributes:
  - function_name: The name of the Lambda function.
EOT
  type = list(object({
    function_name = string
  }))
  default = []
}

variable "tags" {
  description = "A map of tags to assign to the EventBridge rule."
  type        = map(string)
  default     = {}
}
