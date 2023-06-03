resource "aws_s3_object" "lambda_tmnt_api" {
  bucket = aws_s3_bucket.lambda_tmnt_api.id
  key    = "lambda.zip"
  source = data.archive_file.lambda_tmnt_api.output_path
}

resource "aws_lambda_function" "tmnt_api" {
  filename         = data.archive_file.lambda_tmnt_api.output_path
  function_name    = "tmnt_api"
  role             = aws_iam_role.iam_lambda_role.arn
  handler          = "lambda.lambda_handler"
  source_code_hash = data.archive_file.lambda_tmnt_api.output_base64sha256
  runtime          = "python3.10"
}

resource "aws_lambda_permission" "apigw_lambda_allow" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.tmnt_api.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "arn:aws:execute-api:${var.aws_region}:${var.aws_account_id}:${var.aws_api_gateway_rest_api.id}/*/${var.aws_api_gateway_method.http_method}${var.aws_api_gateway_resource_turtles.path}"
} 
