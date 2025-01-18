variable "api_name" {
  description = "The name of the API Gateway"
  type        = string
}

variable "protocol_type" {
  description = "The protocol type for the API Gateway (HTTP or WEBSOCKET)"
  type        = string
  default     = "HTTP"
}

variable "api_description" {
  description = "A description for the API Gateway"
  type        = string
  default     = "API Gateway v2 created by Terraform"
}

variable "stage_name" {
  description = "The deployment stage name (e.g., dev, prod)"
  type        = string
  default     = "dev"
}

variable "auto_deploy" {
  description = "Whether changes to the API should be auto-deployed"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to assign to the gateway"
  type        = map(string)
  default     = {}
}

variable "routes" {
  description = <<EOT
  A map of routes where:
    - route_key: HTTP method and path (e.g., "GET /resource")
    - target: Integration ID (optional; linked to backend)
    - integration_type: Type of integration (e.g., AWS_PROXY, MOCK)
    - integration_method: HTTP method for backend integration (e.g., POST)
    - integration_uri: URI for backend integration (e.g., Lambda function ARN)
    - authorization_type: NONE, AWS_IAM, etc.
  EOT
  type = map(object({
    route_key         = string
    integration_type  = optional(string)
    integration_method = optional(string)
    integration_uri   = optional(string)
    authorization_type = optional(string)
  }))
  default = {}
}

variable "apigateway_lambda_permissions" {
  description = <<EOT
A list of Lambda permissions to allow API Gateway to invoke the Lambda function. 
Each permission is an object with the following attributes:
  - function_name: The name of the Lambda function.
EOT
  type = list(object({
    function_name = string
  }))
  default = []
}
