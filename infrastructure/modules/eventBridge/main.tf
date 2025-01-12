# eventBridge rule
resource "aws_cloudwatch_event_rule" "this" {
  name        = var.rule_name
  description = var.description
  event_bus_name = var.event_bus_name
  event_pattern = var.event_pattern
  schedule_expression = var.schedule_expression
  tags        = var.tags
}

# eventBridge target
resource "aws_cloudwatch_event_target" "this" {
  count          = length(var.targets)
  rule           = aws_cloudwatch_event_rule.this.name
  arn            = var.targets[count.index].arn
  input          = var.targets[count.index].input
  input_path     = var.targets[count.index].input_path
}

# Lambda permissions
resource "aws_lambda_permission" "eventbridge" {
  count        = length(var.lambda_permissions)
  statement_id = "AllowExecutionFromEventBridge-${count.index}"
  action       = "lambda:InvokeFunction"
  function_name = var.lambda_permissions[count.index].function_name
  principal    = "events.amazonaws.com"
  source_arn   = aws_cloudwatch_event_rule.this.arn
}
