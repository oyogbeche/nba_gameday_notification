variable "tags" {
  type = map(string)
}

variable "function_name" {
  type = string
}

variable "gd_lambda_policies" {
  type = map(object({
    Version = string
    Statement = list(object({
      Effect   = string
      Action   = list(string)
      Resource = list(string)
    }))
  }))
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

variable "table_name" {
  type = string
}

variable "hash_key" {
  type = string
}

variable "hash_key_type" {
  type = string
}

variable "gp_function_name" {
  type = string
}

variable "game_preference_handler" {
  type = string
}

variable "gp_lambda_policies" {
  description = "A map of policies to attach to the Lambda role"
  type = map(object({
    Version = string
    Statement = list(object({
      Effect   = string
      Action   = list(string)
      Resource = list(string)
    }))
  }))
}

variable "gp_lambda_source_path" {
  type = string
}

variable "gp_zip_output_path" {
  type = string
}

variable "gp_environment_variables" {
  type = map(string)
}

variable "api_name" {
  type = string
}

variable "protocol_type" {
  type = string
}

variable "auto_deploy" {
  type = bool
}

variable "stage_name" {
  type = string
}

variable "api_gw_lambda_permissions" {
  type = list(object({
    function_name = string
  }))
}

variable "routes" {
  type = map(object({
    route_key          = string
    target             = optional(string)
    integration_type   = optional(string)
    integration_method = optional(string)
    integration_uri    = optional(string)
    authorization_type = optional(string)
  }))
}

variable "email_identity" {
  type = string
}

variable "bucket_name" {
  type = string
}

variable "bucket_policy" {
  type = string
}

variable "origin_domain_name" {
  type = string
}

variable "origin_ssl_protocols" {
  type = list(string)
}

variable "origin_id" {
  type = string
}