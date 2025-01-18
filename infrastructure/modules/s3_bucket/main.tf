resource "aws_s3_bucket" "bucket" {
  bucket        = var.bucket_name
  force_destroy = var.force_destroy
  tags = var.tags
}

resource "aws_s3_bucket_versioning" "bucket_versioning" {
  bucket = aws_s3_bucket.bucket.id

  versioning_configuration {
    status = var.versioning_enabled ? "Enabled" : "Suspended"
  }
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  count  = var.create_bucket_policy ? 1 : 0
  bucket = aws_s3_bucket.bucket.id
  policy = var.bucket_policy
}
