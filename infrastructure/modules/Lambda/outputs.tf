output "lambda_arn" {
  description = "ARN of the created Lambda function"
  value       = aws_lambda_function.lambda.arn
}

output "role_arn" {
  description = "ARN of the IAM role used by the Lambda function"
  value       = aws_iam_role.lambda_execution.arn
}

output "invoke_arn" {
  value = aws_lambda_function.lambda.invoke_arn
}