resource "aws_ssm_parameter" "lambda_secure_string_access_key" {
  name        = "/lambda_secure_string/access_key"
  description = "AWS Access Key Source Account"
  type        = "SecureString"
  value       = var.access_key
  key_id      = aws_kms_key.lambda_kms_key.key_id
}

resource "aws_ssm_parameter" "lambda_secure_string_secret_access_key" {
  name        = "/lambda_secure_string/secret_access_key"
  description = "AWS Secret Access Key Source Account"
  type        = "SecureString"
  value       = var.secret_access_key
  key_id      = aws_kms_key.lambda_kms_key.key_id
}