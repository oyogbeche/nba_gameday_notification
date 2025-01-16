variable "table_name" {
  description = "Name of the DynamoDB table"
  type        = string
}

variable "billing_mode" {
  description = "Billing mode (PROVISIONED or PAY_PER_REQUEST)"
  type        = string
  default     = "PAY_PER_REQUEST"
}

variable "hash_key" {
  description = "The primary hash key for the DynamoDB table"
  type        = string
}

variable "hash_key_type" {
  description = "The data type for the hash key (e.g., S, N, B)"
  type        = string
}

variable "range_key" {
  description = "The primary range key for the DynamoDB table (optional)"
  type        = string
  default     = null
}

variable "range_key_type" {
  description = "The data type for the range key (e.g., S, N, B)"
  type        = string
  default     = null
}

variable "read_capacity" {
  description = "Read capacity for provisioned mode (ignored if PAY_PER_REQUEST)"
  type        = number
  default     = 5
}

variable "write_capacity" {
  description = "Write capacity for provisioned mode (ignored if PAY_PER_REQUEST)"
  type        = number
  default     = 5
}

variable "global_secondary_indexes" {
  description = "A list of Global Secondary Indexes (GSIs)"
  type = list(object({
    name            = string
    hash_key        = string
    range_key       = optional(string)
    projection_type = string
    read_capacity   = number
    write_capacity  = number
  }))
  default = []
}

variable "tags" {
  description = "Tags to assign to the table"
  type        = map(string)
  default     = {}
}

variable "enable_ttl" {
  description = "Whether to enable TTL (Time To Live)"
  type        = bool
  default     = false
}

variable "ttl_attribute" {
  description = "The attribute to use for TTL (if enabled)"
  type        = string
  default     = null
}
