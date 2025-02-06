resource "aws_s3_bucket" "terraform_state" {
  bucket = var.bucket_backend_name

  lifecycle {
    prevent_destroy = true  
  }
}