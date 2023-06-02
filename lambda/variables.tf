variable "aws_account_id" {
  description = "AWS Account ID"
  type = string
}

variable "aws_region" {
  description = "AWS Region to deploy the lambda resources"
  type = string
}

variable "aws_api_gateway_rest_api" {
  description = "AWS API Gateway REST API Object passed from the parent resource layer in the stack"
  type = object({
    id = string
  })
}

variable "aws_api_gateway_resource_turtles" {
  description = "AWS API Gateway Resource Object 'turtles' passed from the parent resource layer in the stack"
  type = object({
    path = string
    
  })
}

variable "aws_api_gateway_method" {
  description = "AWS API Gateway Method Object passed from the parent resource layer in the stack"
  type = object({
    http_method = string
  })
}