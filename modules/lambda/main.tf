resource "aws_lambda_function" "this" {
  function_name = var.function_name
  role          = var.role_arn
  handler       = "index.handler"
  runtime       = "nodejs14.x"

  filename         = var.filename
  source_code_hash = filebase64sha256(var.filename)
}
