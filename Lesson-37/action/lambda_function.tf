resource "aws_lambda_function" "this" {
  function_name    = var.name
  description      = "Created by Terraform"
  role             = aws_iam_role.lambda.arn
  runtime          = "python3.13"
  handler          = "lambda_function.lambda_handler"
  filename         = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  tags             = var.tags

  lifecycle {
    action_trigger {
      events  = [after_create, after_update]
      actions = [action.aws_lambda_invoke.this]
    }
  }
}

action "aws_lambda_invoke" "this" {
  config {
    function_name = aws_lambda_function.this.function_name
    payload = jsonencode({
      Message = "Triggered by Terraform Action"
    })
  }
}

# terraform apply -invoke action.aws_lambda_invoke.count
action "aws_lambda_invoke" "count" {
  count = 5
  config {
    function_name = aws_lambda_function.this.function_name
    payload = jsonencode({
      Message      = "Triggered by Terraform Action"
      InvokeNumber = count.index + 1
    })
  }
}
