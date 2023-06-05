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

  tracing_config {
    mode = "Active"
  }
}

resource "aws_lambda_permission" "allow_lambda_invoke" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.tmnt_api.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.tmnt_api.execution_arn}/*/*/*"
}

resource "aws_lambda_permission" "allow_cognito_invoke" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.jwt_validator.function_name
  principal     = "cognito-idp.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.tmnt_api.execution_arn}/*/*/*"
}

data "local_file" "lambda" {
  filename = "${path.module}/src/lambda.py"
}

data "archive_file" "lambda_tmnt_api" {
  type        = "zip"
  source {
    filename = data.local_file.lambda.filename
    content = data.local_file.lambda.content
  }
  output_path = "${path.module}/src/lambda.zip"
}