data "archive_file" "zip_the_python_code" {
  type        = "zip"
  source_dir  = "../src/"
  output_path = "${path.module}/python/hello-python.zip"
}

resource "aws_lambda_function" "terraform_lambda_func" {
  filename      = "${path.module}/python/hello-python.zip"
  function_name = "<your-name>_terraform_lambda_func"
  role          = "arn:aws:iam::156058766667:role/lambda-execution-role"
  handler       = "lambda_1.lambda_handler"
  runtime       = "python3.9"

  environment {
    variables = {
      my_password = "my_password"
    }
  }

}
