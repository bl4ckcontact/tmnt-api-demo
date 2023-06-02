resource "aws_api_gateway_rest_api" "tmnt_api" {
  name          = "tmnt-api"
  description   = "TMNT API"
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_resource" "turtles" {
  rest_api_id = aws_api_gateway_rest_api.tmnt_api.id
  parent_id   = aws_api_gateway_rest_api.tmnt_api.root_resource_id
  path_part   = "turtles"
}

resource "aws_api_gateway_resource" "goodguys" {
  rest_api_id = aws_api_gateway_rest_api.tmnt_api.id
  parent_id   = aws_api_gateway_rest_api.tmnt_api.root_resource_id
  path_part   = "goodguys"
}

resource "aws_api_gateway_resource" "badguys" {
  rest_api_id = aws_api_gateway_rest_api.tmnt_api.id
  parent_id   = aws_api_gateway_rest_api.tmnt_api.root_resource_id
  path_part   = "badguys"
}

resource "aws_api_gateway_method" "any" {
  rest_api_id   = aws_api_gateway_rest_api.tmnt_api.id
  resource_id   = aws_api_gateway_resource.turtles.id
  http_method   = "ANY"
  authorization = "NONE"
  authorizer_id = aws_api_gateway_resource.turtles.id
}

resource "aws_api_gateway_integration" "apigw_integration" {
  rest_api_id             = aws_api_gateway_rest_api.tmnt_api.id
  resource_id             = aws_api_gateway_resource.turtles.id
  http_method             = aws_api_gateway_method.any.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  #uri                     = "arn:aws:apigateway:${var.aws_region}:lambda:path/2015-03-31/functions/${aws_lambda_function.tmnt_lambda.arn}/invocations"
  uri                     = module.lambda.aws_lambda_function_invoke_arn
}

resource "aws_api_gateway_deployment" "apigw_deployment" {
  rest_api_id = aws_api_gateway_rest_api.tmnt_api.id
  stage_name  = "prod"
  depends_on = [aws_api_gateway_integration.apigw_integration]

  variables = {
    resources = join(",", [aws_api_gateway_resource.turtles.id, aws_api_gateway_resource.goodguys.id, aws_api_gateway_resource.badguys.id])
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_authorizer" "apigw_authorizer" {
  name                   = "apigw_authorizer"
  rest_api_id            = aws_api_gateway_rest_api.tmnt_api.id
  type                   = "COGNITO_USER_POOLS"
  identity_source        = "method.request.header.Authorization"
  provider_arns          = [aws_cognito_user_pool.cognito_user_pool.arn]
}

# resource "aws_api_gateway_method" "get_turtles" {
#   rest_api_id   = aws_api_gateway_rest_api.tmnt_api.id
#   resource_id   = aws_api_gateway_resource.turtles.id
#   http_method   = "GET"
#   authorization = "COGNITO_USER_POOLS"
#   authorizer_id = aws_api_gateway_authorizer.apigw_authorizer.id
# }

# resource "aws_api_gateway_method" "get_turtle" {
#   rest_api_id  = aws_api_gateway_rest_api.tmnt_api.id
#   resource_id  = aws_api_gateway_resource.turtles.id
#   http_method  = "GET"
# }