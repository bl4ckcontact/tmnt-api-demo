resource "aws_cognito_user_pool" "cognito_user_pool" {
  name = "tmnt-cognito-user-pool"
  admin_create_user_config {
    allow_admin_create_user_only = false
  }
}

resource "aws_cognito_user" "cognito_user" {
  user_pool_id  = aws_cognito_user_pool.cognito_user_pool.id
  username      = "tmnt-user"
  #password      = "tmnt-password"
}
