variable "bucket_name" {
  description = "The name of the S3 bucket."
  type        = string
}

variable "force_destroy" {
  description = "Whether all objects (including versions) should be deleted when destroying the bucket."
  type        = bool
  default     = false
}

variable "versioning_enabled" {
  description = "Enable versioning for the S3 bucket."
  type        = bool
  default     = false
}

variable "tags" {
  description = "A map of tags to apply to the S3 bucket."
  type        = map(string)
  default     = {}
}

variable "create_bucket_policy" {
  description = "Whether to create a bucket policy."
  type        = bool
  default     = false
}

variable "bucket_policy" {
  description = "JSON policy for the bucket."
  type        = string
  default     = ""
}
