resource "aws_iam_role" "lambda_execution" {
  name = "${var.function_name}_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "lambda_policy" {
  for_each = var.policies

  name = "${var.function_name}-${each.key}-policy"
  role = aws_iam_role.lambda_execution.id

  policy = jsonencode(each.value)
}

data "archive_file" "python_zip" {
  type        = "zip"
  source_file = var.lambda_source_path
  output_path = var.zip_output_path
}

resource "aws_lambda_function" "lambda" {
  function_name = var.function_name
  role          = aws_iam_role.lambda_execution.arn
  handler       = var.handler
  runtime       = var.runtime
  filename      = data.archive_file.python_zip.output_path
  timeout       = var.timeout
  memory_size   = var.memory_size
  source_code_hash = data.archive_file.python_zip.output_base64sha256

  environment {
    variables = var.environment_variables
  }

  tags = var.tags
}

resource "aws_cloudwatch_log_group" "lambda_logs" {
  name              = "/aws/lambda/${aws_lambda_function.lambda.function_name}"
  retention_in_days = var.log_retention
}
