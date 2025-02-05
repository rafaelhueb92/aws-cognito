resource "aws_cognito_user_pool" "user_pool" {
  name = "people-user-pool"
}

resource "aws_cognito_user_pool_client" "user_pool_client" {
  name         = "people-client"
  user_pool_id = aws_cognito_user_pool.user_pool.id
  generate_secret = true
}

resource "aws_cognito_user" "default_user" {
  user_pool_id = aws_cognito_user_pool.user_pool.id
  username     = var.cognito_email
  password     = var.cognito_password
}

resource "aws_cognito_user_pool_domain" "this" {
  domain          = "people-auth"
  user_pool_id    = aws_cognito_user_pool.user_pool.id
}

resource "aws_cognito_user_pool_client" "this" {
  name                                 = "people-client"
  user_pool_id                         = aws_cognito_user_pool.user_pool.id
  generate_secret                      = false
  explicit_auth_flows                  = ["ALLOW_REFRESH_TOKEN_AUTH", "ALLOW_USER_SRP_AUTH"]
  allowed_oauth_flows                  = ["code", "implicit"]
  allowed_oauth_scopes                 = ["openid", "email", "profile"]
  allowed_oauth_flows_user_pool_client = true

  callback_urls = ["http://localhost:3000/callback"]
  #logout_urls   = ["https://myfrontend.com/logout"]
}

resource "aws_cognito_ui_customization" "ui_customization" {
  user_pool_id = aws_cognito_user_pool.my_user_pool.id
  client_id    = aws_cognito_user_pool_client.my_app_client.id
  css          = file("custom-style.css")  # Custom CSS file
}
