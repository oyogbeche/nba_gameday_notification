variable "origin_domain_name" {
  description = "The domain name of the origin resource (e.g., S3 bucket or custom domain)."
  type        = string
}

variable "origin_id" {
  description = "A unique identifier for the origin."
  type        = string
}

variable "origin_http_port" {
  description = "The HTTP port the origin listens on."
  type        = number
  default     = 80
}

variable "origin_https_port" {
  description = "The HTTPS port the origin listens on."
  type        = number
  default     = 443
}

variable "origin_protocol_policy" {
  description = "The protocol policy for the origin (http-only, https-only, or match-viewer)."
  type        = string
  default     = "https-only"
}

variable "viewer_protocol_policy" {
  description = "The protocol policy for the cache behavior (allow-all, redirect-to-https, or https-only)."
  type        = string
  default     = "redirect-to-https"
}

variable "allowed_methods" {
  description = "Allowed HTTP methods for cache behavior."
  type        = list(string)
  default     = ["GET", "HEAD"]
}

variable "cached_methods" {
  description = "Cached HTTP methods for cache behavior."
  type        = list(string)
  default     = ["GET", "HEAD"]
}

variable "forward_query_string" {
  description = "Whether to forward query strings to the origin."
  type        = bool
  default     = false
}

variable "forward_cookies" {
  description = "How cookies are forwarded to the origin (none, all, or whitelist)."
  type        = string
  default     = "none"
}

variable "enable_compression" {
  description = "Whether to enable compression for CloudFront."
  type        = bool
  default     = true
}

variable "min_ttl" {
  description = "Default TTL for objects in the cache."
  type        = number
  default     = 0
}
variable "default_ttl" {
  description = "Default TTL for objects in the cache."
  type        = number
  default     = 86400
}
variable "max_ttl" {
  description = "Default TTL for objects in the cache."
  type        = number
  default     = 31536000
}

variable "price_class" {
  description = "The CloudFront price class (PriceClass_All, PriceClass_200, PriceClass_100)."
  type        = string
  default     = "PriceClass_100"
}

variable "enabled" {
  description = "Whether the CloudFront distribution is enabled."
  type        = bool
  default     = true
}

variable "geo_restriction_type" {
  description = "The type of geo restriction (whitelist, blacklist, none)."
  type        = string
  default     = "none"
}

variable "geo_restriction_locations" {
  description = "List of country codes for geo restriction."
  type        = list(string)
  default     = []
}

variable "minimum_protocol_version" {
  description = "Minimum SSL/TLS protocol version for HTTPS."
  type        = string
  default     = "TLSv1.2_2021"
}

variable "cloudfront_default_certificate" {
  description = "Whether to use the default CloudFront certificate."
  type        = bool
  default     = false
}

variable "origin_ssl_protocols" {
  description = "protocols and encryption standards used for secure communication over HTTPS"
  type = list(string)
}

variable "tags" {
  description = "A map of tags to apply to the CloudFront distribution."
  type        = map(string)
  default     = {}
}
