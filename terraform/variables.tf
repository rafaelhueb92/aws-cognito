variable "cognito_email" {
  description = "Default Cognito User Email"
  type        = string
}

variable "cognito_password" {
  description = "Default Cognito User Password"
  type        = string
}

variable "bucket_backend_name" {
  description = "Default name bucket backend"
  type        = string
  default     = "aws-cognito-gtw-lambda-backend-bucket"
}