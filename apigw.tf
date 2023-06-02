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

resource "aws_api_gateway_method" "any" {
  rest_api_id   = aws_api_gateway_rest_api.tmnt_api.id
  resource_id   = aws_api_gateway_resource.turtles.id
  http_method   = "ANY"
  authorization = "NONE"
  authorizer_id = aws_api_gateway_resource.turtles.id
}

# resource "aws_api_gateway_method" "get_turtle" {
#   rest_api_id  = aws_api_gateway_rest_api.tmnt_api.id
#   resource_id  = aws_api_gateway_resource.turtles.id
#   http_method  = "GET"
# }