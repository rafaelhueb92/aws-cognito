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
    bucket         = var.bucket_backend_name
    key            = "terraform/state.tfstate"    
    region         = "us-east-1"                  
    encrypt        = true                         
    dynamodb_table = "terraform-locks"            
  }
}