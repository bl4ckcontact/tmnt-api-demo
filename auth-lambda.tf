resource "aws_iam_role" "cognito_auth_jwt" {
  name = "cognito_auth_jwt"
  assume_role_policy = <<ITEM
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "cognito-idp.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
ITEM
}


resource "aws_s3_object" "jwt_validator" {
  bucket = aws_s3_bucket.lambda_tmnt_api.id
  key    = "decode_verify_jwt.zip"
  source = data.archive_file.lambda_tmnt_api.output_path
}

resource "aws_lambda_function" "jwt_validator" {
  filename         = "${path.module}/src/decode_verify_jwt.zip"
  function_name    = "decode_verify_jwt"
  role             = aws_iam_role.iam_lambda_role.arn
  handler          = "decode_verify_jwt.lambda_handler"
  runtime          = "python3.10"

  environment {
    variables = {
      USER_POOL_ID = aws_cognito_user_pool.user_pool.id
      APPLICATION_CLIENT_ID = aws_cognito_user_pool_client.user_pool_client.id
      ADMIN_GROUP_NAME = aws_cognito_user_group.admins_user_pool_admin_group.name
    }
  }
  tracing_config {
    mode = "Active"
  }
}

# resource "aws_lambda_permission" "jwt_validator_allow" {
#   statement_id  = "AllowAPIGatewayInvokeValidator"
#   action        = "lambda:InvokeFunction"
#   function_name = aws_lambda_function.tmnt_api.function_name
#   principal     = "apigateway.amazonaws.com"
#   source_arn    = "${aws_api_gateway_rest_api.tmnt_api.execution_arn}/*/*/*"
# }

data "archive_file" "jwt_validator" {
  type        = "zip"
  # source {
  #   content = local_file.jwt_validator_py.content
  #   filename = local_file.jwt_validator_py.filename
  # }
  source_file = data.local_file.jwt_validator_py.filename
  output_path = "${path.module}/src/decode_verify_jwt.zip"
  #depends_on = [ local_file.jwt_validator_py ]
}

# resource "local_file" "jwt_validator" {
#   filename = "${path.module}/src/decode_verify_jwt.py"
#   content = templatefile("${path.module}/src/decode_verify_jwt.py.tpl", {
#     cognito_user_pool_id = aws_cognito_user_pool.user_pool.id,
#     cognito_app_client_id = aws_cognito_user_pool_client.user_pool_client.id
#     aws_region   = var.aws_region
#   })
# }

# resource "local_file" "jwt_validator_py" {
#   filename = "${path.module}/src/decode_verify_jwt.py"
#   source = "${path.module}/src/decode_verify_jwt.py"
#   #depends_on = [local_file.jwt_validator]
# }

data "local_file" "jwt_validator_py" {
  filename = "${path.module}/src/decode_verify_jwt.py"
}