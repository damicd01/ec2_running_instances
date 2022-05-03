resource "aws_kms_key" "lambda_kms_key" {
  description         = "lambda_kms_key"
  key_usage           = "ENCRYPT_DECRYPT"
  enable_key_rotation = true
}

resource "aws_kms_alias" "lambda_kms_key" {
  name          = "alias/lambda_kms_key"
  target_key_id = aws_kms_key.lambda_kms_key.key_id
}
