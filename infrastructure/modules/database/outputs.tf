output "table_name" {
  description = "The name of the DynamoDB table"
  value       = aws_dynamodb_table.dynamodb.name
}

output "table_arn" {
  description = "The ARN of the DynamoDB table"
  value       = aws_dynamodb_table.dynamodb.arn
}
