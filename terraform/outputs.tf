output "api_gateway_url" {
  value = aws_apigatewayv2_api.api.api_endpoint
}

output "lambda_arn" { 
  value = aws_lambda_function.get_all_people.arn
}

output "cognito_domain" {
  value = aws_cognito_user_pool_domain.this.domain
  description = "The domain of the Cognito User Pool"
}