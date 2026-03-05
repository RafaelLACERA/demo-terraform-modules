resource "random_string" "random" {
    length = 10
    upper   = false
    special = false
}

module "lambda_s3" {
    source = "../module"
    
    bucket_name   = "bucket-${random_string.random.result}"
    lambda_name   = "lambda-${random_string.random.result}"
    code_archive  = "../data/lambda.zip"
}