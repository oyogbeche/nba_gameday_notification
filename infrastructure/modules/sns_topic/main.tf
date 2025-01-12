
resource "aws_sns_topic" "this" {
  name                      = var.name
  display_name              = var.display_name
  fifo_topic                = var.fifo_topic
  content_based_deduplication = var.content_based_deduplication
  tags                      = var.tags
}

# Optional: Allow subscribing to the SNS topic from specific AWS accounts or services
resource "aws_sns_topic_policy" "this" {
  count      = var.enable_policy ? 1 : 0
  arn        = aws_sns_topic.this.arn
  policy     = var.policy
}

resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.this.arn
  protocol  = "email"
  endpoint  = var.email
  raw_message_delivery = var.raw_message_delivery
}

resource "aws_sns_topic_subscription" "sms_subscription" {
  topic_arn = aws_sns_topic.this.arn
  protocol  = "sms"
  endpoint  = var.phone_number
  raw_message_delivery = var.raw_message_delivery
}
