resource "aws_s3_bucket" "lambda_tmnt_api" {
  bucket = "lambda-tmnt-api"
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

data "archive_file" "lambda_tmnt_api" {
  type        = "zip"
  source_dir  = "${path.module}/src"
  output_path = "${path.module}/lambda.zip"
}
