resource "aws_sns_topic" "ses_alarms" {
  name         = "ses-alarms"
  display_name = "SES Alarms"
}

resource "aws_ses_identity_notification_topic" "bounces" {
  topic_arn                = aws_sns_topic.ses_alarms.arn
  identity                 = aws_ses_domain_identity.cov_clear.domain
  notification_type        = "Bounce"
  include_original_headers = false
}

resource "aws_ses_identity_notification_topic" "complaints" {
  topic_arn                = aws_sns_topic.ses_alarms.arn
  identity                 = aws_ses_domain_identity.cov_clear.domain
  notification_type        = "Complaint"
  include_original_headers = false
}

