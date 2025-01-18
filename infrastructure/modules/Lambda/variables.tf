variable "function_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "handler" {
  description = "The entry point in your code (e.g., handler.lambda_handler)"
  type        = string
}

variable "runtime" {
  description = "Runtime for the Lambda function (e.g., python3.9, nodejs14.x)"
  type        = string
}

variable "lambda_source_path" {
  description = "Path to the directory containing Lambda source code"
  type        = string
}

variable "zip_output_path" {
  description = "path to the directory to store the Lambda zip output"
  type = string
  default = "/src/gd_notification.zip"
}

variable "timeout" {
  description = "Maximum execution time for the Lambda function in seconds"
  type        = number
  default     = 3
}

variable "memory_size" {
  description = "Amount of memory allocated to the Lambda function in MB"
  type        = number
  default     = 128
}

variable "log_retention" {
  description = "Retention period for Lambda logs in CloudWatch (in days)"
  type        = number
  default     = 7
}

variable "environment_variables" {
  description = "Environment variables for the Lambda function"
  type        = map(string)
  default     = {}
}

variable "policies" {
  description = "A map of policies to attach to the Lambda role"
  type        = map(object({
    Version   = string
    Statement = list(object({
      Effect   = string
      Action   = list(string)
      Resource = list(string)
    }))
  }))
}

variable "tags" {
  description = "Tags to associate with the Lambda function"
  type        = map(string)
  default     = {}
}
