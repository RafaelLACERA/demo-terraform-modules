output "output_bucket_name" {
  value = aws_s3_bucket.s3_module.bucket
  description = "Bucket name"
}
output "lambda_name" {
  value = aws_lambda_function.func.function_name
  description = "value"
}
