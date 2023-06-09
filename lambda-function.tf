
data "archive_file" "lambda_api_function" {
  type        = "zip"
  source_file = var.source_file
  output_path = var.lambda_zip_location
}

resource "aws_lambda_function" "AWS_S3_API_Lambda_Function" {
  filename         = var.lambda_zip_location
  function_name    = var.function_name
  role             = aws_iam_role.api_role.arn
  handler          = "lambda_api_function.lambda_handler"
  source_code_hash = filebase64sha256(var.lambda_zip_location)
  runtime          = var.runtime
  environment {
    variables = {
      CreatedBy = "Terraform"
    }
  }
  depends_on = [data.archive_file.lambda_api_function]
}

resource "aws_s3_bucket_notification" "aws-lambda-trigger" {
  bucket = aws_s3_bucket.api_bucket.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.AWS_S3_API_Lambda_Function.arn
    events              = ["s3:ObjectCreated:*", "s3:ObjectRemoved:*", "s3:ObjectRestore:*"]
  }
  depends_on = [
    aws_lambda_permission.allow_bucket
  ]
}

resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowS3Invoke"
  action        = "lambda:invokeFunction"
  function_name = aws_lambda_function.AWS_S3_API_Lambda_Function.arn
  principal     = "s3.amazonaws.com"
  source_arn    = "arn:aws:s3:::${aws_s3_bucket.api_bucket.id}"
}

resource "aws_cloudwatch_log_group" "cloudwatch_logs" {
  name              = "/aws/lambda/${var.function_name}"
  retention_in_days = 14
}