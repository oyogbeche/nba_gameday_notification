output "api_url" {
  value = module.aws_apigatewayv2_api.api_endpoint
}

output "stage_name" {
  value = module.aws_apigatewayv2_api.stage_name
}
