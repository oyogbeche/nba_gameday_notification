module "lambda_function" {
  source                = "./modules/Lambda"
  function_name         = var.function_name
  policies              = var.gd_lambda_policies
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

module "dynamodb" {
  source        = "./modules/database"
  table_name    = var.table_name
  hash_key      = var.hash_key
  hash_key_type = var.hash_key_type
  tags          = var.tags
}

module "game_preference_lambda" {
  source                = "./modules/Lambda"
  function_name         = var.gp_function_name
  handler               = var.game_preference_handler
  policies              = var.gp_lambda_policies
  runtime               = var.runtime
  lambda_source_path    = var.gp_lambda_source_path
  zip_output_path       = var.gp_zip_output_path
  environment_variables = var.gp_environment_variables
  tags                  = var.tags
}

module "aws_apigatewayv2_api" {
  source                        = "./modules/api_gateway"
  api_name                      = var.api_name
  protocol_type                 = var.protocol_type
  auto_deploy                   = var.auto_deploy
  routes                        = var.routes
  stage_name                    = var.stage_name
  apigateway_lambda_permissions = var.api_gw_lambda_permissions
  tags                          = var.tags
}

module "ses" {
  source                = "./modules/ses"
  create_email_identity = true
  email_identity        = var.email_identity
}

module "s3_bucket" {
  source               = "./modules/s3_bucket"
  bucket_name          = var.bucket_name
  create_bucket_policy = true
  bucket_policy        = var.bucket_policy
  tags                 = var.tags
}

module "cloudfront" {
  source                         = "./modules/cloudfront"
  origin_domain_name             = var.origin_domain_name
  origin_ssl_protocols           = var.origin_ssl_protocols
  origin_id                      = var.origin_id
  origin_protocol_policy         = "https-only"
  viewer_protocol_policy         = "redirect-to-https"
  allowed_methods                = ["GET", "HEAD", "OPTIONS"]
  cached_methods                 = ["GET", "HEAD", ]
  default_ttl                    = 3600
  cloudfront_default_certificate = true
  tags                           = var.tags
}