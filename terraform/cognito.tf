resource "aws_cognito_user_pool" "user_pool" {
  name = "people-user-pool"
}

resource "aws_cognito_user_pool_client" "user_pool_client" {
  name         = "people-client"
  user_pool_id = aws_cognito_user_pool.user_pool.id
  generate_secret = false
}

resource "aws_cognito_user" "default_user" {
  user_pool_id = aws_cognito_user_pool.user_pool.id
  username     = var.cognito_email
  password     = var.cognito_password
}