provider "aws" {
  region = "us-east-1"

  # Default tags for all resources
  default_tags {
    tags = {
      Environment = "dev"
      Project     = "aws-cognito-api-gtw-lambda"
    }
  }
}