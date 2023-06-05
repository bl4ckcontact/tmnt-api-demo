resource "aws_cognito_user_pool" "user_pool" {
  name = "tmnt-user-pool"
  username_attributes = ["email"]
  auto_verified_attributes = ["email"]
  email_verification_subject = "Get your demo on with this code!"
  email_verification_message = "Your verification code is {####}"

  admin_create_user_config {
    allow_admin_create_user_only = false
  }

  email_configuration {
    email_sending_account = "COGNITO_DEFAULT"
  }

  password_policy {
    minimum_length = 12
    require_lowercase = true
    require_numbers = true
    require_symbols = true
    require_uppercase = true
    temporary_password_validity_days = 7
  }

  schema {
    name = "email"
    attribute_data_type = "String"
    developer_only_attribute = false
    mutable = true
    required = true
    string_attribute_constraints {
      max_length = 2048
      min_length = 0
    }
  }
  username_configuration {
    case_sensitive = false
  }

  # lambda_config {
  #   create_auth_challenge          = aws_lambda_function.jwt_validator.arn
  #   custom_message                 = aws_lambda_function.jwt_validator.arn
  #   define_auth_challenge          = aws_lambda_function.jwt_validator.arn
  #   post_authentication            = aws_lambda_function.jwt_validator.arn
  #   post_confirmation              = aws_lambda_function.jwt_validator.arn
  #   pre_authentication             = aws_lambda_function.jwt_validator.arn
  #   pre_sign_up                    = aws_lambda_function.jwt_validator.arn
  #   pre_token_generation           = aws_lambda_function.jwt_validator.arn
  #   user_migration                 = aws_lambda_function.jwt_validator.arn
  #   verify_auth_challenge_response = aws_lambda_function.jwt_validator.arn
  # }
}

resource "aws_cognito_user_pool_client" "user_pool_client" {
  name = "tmnt-user-pool-client"
  user_pool_id = aws_cognito_user_pool.user_pool.id
  explicit_auth_flows = [
    "ALLOW_CUSTOM_AUTH",
    "ALLOW_USER_SRP_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH"
  ]
  
  generate_secret = false
  supported_identity_providers = ["COGNITO"]
  allowed_oauth_flows_user_pool_client = true
  #allowed_oauth_flows = ["code", "implicit"]
  allowed_oauth_flows = ["implicit"]
  allowed_oauth_scopes = ["email", "openid", "aws.cognito.signin.user.admin"]
  callback_urls = [var.cognito_callback_url]
  logout_urls = [var.cognito_logout_url]
}

resource "aws_cognito_user_pool_domain" "user_pool_domain" {
  domain = "tmnt-user-pool-domain"
  user_pool_id = aws_cognito_user_pool.user_pool.id
}

resource "aws_cognito_identity_pool" "identity_pool" {
  identity_pool_name = "tmnt-identity-pool"
  allow_unauthenticated_identities = false
  cognito_identity_providers {
    client_id = aws_cognito_user_pool_client.user_pool_client.id
    provider_name = aws_cognito_user_pool.user_pool.endpoint
    server_side_token_check = false
  }
}

resource "aws_cognito_user_group" "admins_user_pool_admin_group" {
  name = "apiadmins"
  description = "API Administrator user group"
  #precedence = 0
  user_pool_id = aws_cognito_user_pool.user_pool.id
}
