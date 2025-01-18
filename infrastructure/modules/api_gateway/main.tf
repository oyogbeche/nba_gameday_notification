resource "aws_apigatewayv2_api" "api" {
  name          = var.api_name
  protocol_type = var.protocol_type
  tags = var.tags
  cors_configuration {
    allow_credentials = false
    allow_headers     = []
    allow_methods = [
      "GET",
      "POST",
      "OPTIONS",
    ]
    allow_origins  = ["*"]
    expose_headers = []
    max_age        = 0
  }

  # Optional description
  description = var.api_description
}

resource "aws_apigatewayv2_stage" "stage" {
  api_id      = aws_apigatewayv2_api.api.id
  name        = var.stage_name
  auto_deploy = var.auto_deploy
}

resource "aws_apigatewayv2_route" "route" {
  for_each     = var.routes
  api_id       = aws_apigatewayv2_api.api.id
  route_key    = each.value.route_key 
  target       = lookup(each.value, "target", "integrations/${aws_apigatewayv2_integration.integration[each.key].id}") # Integration ID 
  authorization_type = lookup(each.value, "authorization_type", null)
}

resource "aws_apigatewayv2_integration" "integration" {
  for_each           = var.routes
  api_id             = aws_apigatewayv2_api.api.id
  integration_type   = lookup(each.value, "integration_type", "AWS_PROXY")
  integration_method = lookup(each.value, "integration_method", "POST")
  integration_uri    = lookup(each.value, "integration_uri", null)
  payload_format_version = lookup(each.value, "payload_format_version","2.0")
}

resource "aws_lambda_permission" "api_gateway" {
  count        = length(var.apigateway_lambda_permissions)
  statement_id = "AllowExecutionFromEventBridge-${count.index}"
  action       = "lambda:InvokeFunction"
  function_name = var.apigateway_lambda_permissions[count.index].function_name
  principal    = "apigateway.amazonaws.com"
  source_arn   = "${aws_apigatewayv2_api.api.execution_arn}/*/*"
}
