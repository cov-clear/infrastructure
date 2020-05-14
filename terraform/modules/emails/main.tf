resource "aws_ses_domain_identity" "cov_clear" {
  domain = var.domain
}

resource "aws_ses_email_identity" "no_reply_email" {
  email = "no-reply@${var.domain}"
}
