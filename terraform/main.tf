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

terraform {
  backend "s3" {
    bucket         = "backend-tf-${data.aws_caller_identity.current.account_id}"
    key            = "terraform/state.tfstate"    
    region         = "us-east-1"                  
    encrypt        = true                         
    dynamodb_table = "terraform-locks"            
  }
}