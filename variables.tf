variable "aws_profile" {
  description = "AWS Profile to use for deployment"
  type = string
}

variable "aws_region" {
  description = "AWS Region to deploy the TMNT API stack"
  type = string
  default = "us-west-2"
}

variable "aws_account_id" {
  description = "AWS Account ID"
  type = string
}

variable "cognito_callback_url" {
  description = "Cognito callback URL"
  type = string
}

variable "cognito_logout_url" {
  description = "Cognito logout URL"
  type = string
}