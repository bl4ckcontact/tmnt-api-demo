resource "aws_api_gateway_rest_api" "tmnt_api" {
  name          = "tmnt-api"
  description   = "TMNT API"
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_resource" "resource_root" {
  rest_api_id = aws_api_gateway_rest_api.tmnt_api.id
  parent_id   = aws_api_gateway_rest_api.tmnt_api.root_resource_id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "get" {
  rest_api_id = aws_api_gateway_rest_api.tmnt_api.id
  resource_id = aws_api_gateway_resource.resource_root.id
  http_method = "GET"
  authorization = "NONE"
  request_parameters = {
    "method.request.path.proxy" = true
    "method.request.querystring.name" = false
    "method.request.querystring.type" = false
  }
}

resource "aws_api_gateway_method" "post" {
  rest_api_id = aws_api_gateway_rest_api.tmnt_api.id
  resource_id = aws_api_gateway_resource.resource_root.id
  http_method = "POST"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.cognito_authorizer.id
}

resource "aws_api_gateway_integration" "apigw_integration_get" {
  rest_api_id = aws_api_gateway_rest_api.tmnt_api.id
  resource_id = aws_api_gateway_resource.resource_root.id
  http_method = aws_api_gateway_method.get.http_method
  integration_http_method = "GET"
  type = "AWS_PROXY"
  uri = aws_lambda_function.tmnt_api.invoke_arn
  depends_on = [aws_api_gateway_method.get]
}

resource "aws_api_gateway_integration" "apigw_integration_post" {
  rest_api_id = aws_api_gateway_rest_api.tmnt_api.id
  resource_id = aws_api_gateway_resource.resource_root.id
  http_method = aws_api_gateway_method.post.http_method
  integration_http_method = "POST"
  type = "AWS_PROXY"
  uri = aws_lambda_function.tmnt_api.invoke_arn
  depends_on = [aws_api_gateway_method.post ]
}

resource "aws_api_gateway_deployment" "apigw_deployment" {
  rest_api_id = aws_api_gateway_rest_api.tmnt_api.id
  stage_name  = "prod"
  depends_on = [
    aws_api_gateway_method.get,
    aws_api_gateway_method.post,
    aws_api_gateway_integration.apigw_integration_get,
    aws_api_gateway_integration.apigw_integration_post
  ]

  variables = {
    resources = aws_api_gateway_resource.resource_root.id
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_authorizer" "cognito_authorizer" {
  name                   = "CognitoUserPoolAuthorizer"
  type                   = "COGNITO_USER_POOLS"
  rest_api_id            = aws_api_gateway_rest_api.tmnt_api.id
  identity_source        = "method.request.header.Authorization"
  provider_arns          = [aws_cognito_user_pool.user_pool.arn]
}
