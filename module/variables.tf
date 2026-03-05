    variable "bucket_name" {
      description = "(required) Bucket name where data is received"
      type        = string
    }
    variable "lambda_name" {
      description = "(required) The name of the Lambda function"
      type        = string
    }
    variable "code_archive" {
      description = "(required) Lambda code to deploy"
        type        = string
    
    }