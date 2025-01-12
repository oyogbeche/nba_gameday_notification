module "sns_topic" {
  source       = "./modules/sns_topic"
  name         = var.sns_topic_name
  display_name = var.display_name
  email        = var.email
  phone_number = var.phone_number
  tags         = var.tags
}

module "lambda_function" {
  source                = "./modules/Lambda"
  function_name         = var.function_name
  iam_policy            = var.iam_policy
  handler               = var.lambda_handler
  lambda_source_path    = var.lambda_source_path
  zip_output_path       = var.zip_output_path
  runtime               = var.runtime
  environment_variables = var.environment_variables
  tags                  = var.tags
}

module "eventBridge" {
  source              = "./modules/eventBridge"
  rule_name           = var.rule_name
  targets             = var.targets
  schedule_expression = var.schedule_expression
  lambda_permissions  = var.lambda_permissions
  tags                = var.tags
}
