resource "aws_lambda_function" "this" {
  function_name    = var.name
  description      = "Created by Terraform"
  role             = aws_iam_role.lambda.arn
  runtime          = "python3.13"
  handler          = "lambda_function.lambda_handler"
  filename         = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  tags             = var.tags
}

resource "null_resource" "invoke_lambda" {
  provisioner "local-exec" {
    command = "aws lambda invoke --function-name ${aws_lambda_function.this.function_name} --cli-binary-format raw-in-base64-out --payload '{\"Message\": \"Triggered by Terraform local-exec\"}' /dev/stdout"
  }

  triggers = {
    source_code_hash = aws_lambda_function.this.source_code_hash
  }

  depends_on = [aws_lambda_function.this]
}

