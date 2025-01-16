output "distribution_id" {
  description = "The ID of the CloudFront distribution."
  value       = aws_cloudfront_distribution.cloudfront_distribution.id
}

output "distribution_domain_name" {
  description = "The domain name of the CloudFront distribution."
  value       = aws_cloudfront_distribution.cloudfront_distribution.domain_name
}

output "origin_domain_name" {
  description = "The origin domain name."
  value       = var.origin_domain_name
}
