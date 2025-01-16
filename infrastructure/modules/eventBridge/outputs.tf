output "rule_arn" {
  description = "The ARN of the EventBridge rule."
  value       = aws_cloudwatch_event_rule.eventbridge.arn
}

output "rule_name" {
  description = "The name of the EventBridge rule."
  value       = aws_cloudwatch_event_rule.eventbridge.name
}
