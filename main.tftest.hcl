run "valid_names" {
    #préciser la commande à exécuter pour ce test
command = plan

#Indiquer le chemin du module à tester
 module {
   source = "./module"
 }

#Variables en Input
  variables {
    bucket_name = "bucket-test"
    lambda_name = "lambda-test"
    code_archive = "../../data/lambda.zip"
  }
#Comportemetns que je veux tester
  assert {
    condition = aws_s3_bucket.s3_module.bucket == "bucket-test"
     error_message = "S3 Bucket name did not match expected value"
  }

  assert {
    condition = aws_lambda_function.func.function_name == "lambda-test"
     error_message = "Lambda bucket name did not match expected value"
  }
}