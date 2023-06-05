resource "aws_kms_key" "tmnt_demo_kms_key" {
  enable_key_rotation = true
}

resource "aws_s3_bucket" "log_bucket" {
  bucket = "tmnt-demo-logs"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "log_bucket_sse" {
  bucket = aws_s3_bucket.log_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.tmnt_demo_kms_key.arn
      sse_algorithm = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "log_bucket_public_access_block" {
  bucket = aws_s3_bucket.log_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "log_bucket_versioning" {
  bucket = aws_s3_bucket.log_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_logging" "log_bucket_logging" {
  bucket = aws_s3_bucket.log_bucket.id
  target_bucket = aws_s3_bucket.log_bucket.id
  target_prefix = "log/"
}

resource "aws_s3_bucket" "lambda_tmnt_api" {
  bucket = "lambda-tmnt-api"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "lambda_tmnt_api_sse" {
  bucket = aws_s3_bucket.lambda_tmnt_api.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.tmnt_demo_kms_key.arn
      sse_algorithm = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_versioning" "lambda_tmnt_api_versioning" {
  bucket = aws_s3_bucket.lambda_tmnt_api.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_logging" "lambda_tmnt_api_logging" {
  bucket = aws_s3_bucket.lambda_tmnt_api.id
  target_bucket = aws_s3_bucket.log_bucket.id
  target_prefix = "log/"
}

resource "aws_s3_bucket_public_access_block" "lambda_bucket_public_access_block" {
  bucket = aws_s3_bucket.lambda_tmnt_api.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_ownership_controls" "lambda_bucket_ownership_controls" {
  bucket = aws_s3_bucket.lambda_tmnt_api.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "lambda_bucket_acl" {
  depends_on  = [aws_s3_bucket_ownership_controls.lambda_bucket_ownership_controls]
  bucket      = aws_s3_bucket.lambda_tmnt_api.id
  acl         = "private"
}
