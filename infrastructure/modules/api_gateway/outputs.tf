output "api_id" {
  description = "The ID of the created API Gateway"
  value       = aws_apigatewayv2_api.api.id
}

output "api_endpoint" {
  description = "The endpoint of the created API Gateway"
  value       = aws_apigatewayv2_api.api.api_endpoint
}

output "stage_name" {
  description = "The name of the stage"
  value       = aws_apigatewayv2_stage.stage.name
}
