#random
resource "random_string" "random" {
    length = 10
    upper   = false
    special = false
}
#s3
resource "aws_s3_bucket" "s3_module" {
    bucket = var.bucket_name
    force_destroy = true 
}
data "aws_iam_policy_document" "assume_role"{
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}  

resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy" "policy_one" {
  name   = "policy-for-lambda-${random_string.random.result}"
  role   = aws_iam_role.iam_for_lambda.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "logs:CreateLogGroup", "logs:CreateLogStream", 
          "logs:PutLogEvents", "iam:PassRole"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_lambda_function" "func" {
  function_name = var.lambda_name
  role          = aws_iam_role.iam_for_lambda.arn

  filename      = var.code_archive
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.10"
}
resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowExecutionFromS3"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.func.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.s3_module.arn
  
}

#aws_s3_bucket_notification
resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.s3_module.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.func.arn
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = "input/"
  }
  depends_on = [aws_lambda_permission.allow_bucket]
}