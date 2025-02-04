output "api_gateway_url" {
  value = aws_apigatewayv2_api.api.api_endpoint
}

output "lambda_arn" { 
  value = aws_lambda_function.get_all_people.arn
}