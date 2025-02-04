resource "aws_lambda_function" "lambda_role" {
  function_name    = "getAllPeople"
  runtime          = "nodejs18.x"
  handler          = "main.handler"
  filename         = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  role             = aws_iam_role.lambda_role.arn
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "../app/main.js"
  output_path = "lambda.zip"
}