resource "aws_s3_bucket" "tfstate_bucket" {
  bucket = var.s3_tfstate
  tags = var.default_tags
}

resource "aws_s3_bucket_versioning" "tfstate_bucket_versioning" {
  bucket = aws_s3_bucket.tfstate_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

output "TFSTATE_BUCKET_NAME" {
  value = aws_s3_bucket.tfstate_bucket.bucket
}