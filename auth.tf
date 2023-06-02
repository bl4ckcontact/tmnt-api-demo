resource "aws_cognito_user_pool" "cognito_user_pool" {
  name = "tmnt-cognito-user-pool"
  auto_verified_attributes = ["email"]
}

# resource "aws_cognito_identity_provider" "cognito-idp" {
#   user_pool_id = aws_cognito_user_pool.cognito-user-pool.id
#   provider_name = "Google"
#   provider_type = "Google"

#   provider_details = {
#     authorize_scopes = "email profile openid"
#     client_id = var.google_client_id
#     client_secret = var.google_client_secret
#   }

#   attribute_mapping = "email"
#   username = "sub"
# }