# -----Lambda Package
data "archive_file" "lambda_zip" {
  type        = "zip"
  output_path = "lambda_function.zip"
  source {
    filename = "lambda_function.py"
    content  = file("${path.module}/lambda_function.py")
  }
}

#--------------- Lambda IAM Permissions
resource "aws_iam_role" "lambda" {
  name               = "${var.name}-iam-role"
  tags               = var.tags
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": ["lambda.amazonaws.com"]
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "lambda_policy" {
  name   = "${var.name}-iam-role-policy"
  tags   = var.tags
  policy = <<EOF
{
      "Version": "2012-10-17",
      "Statement": [
          {
              "Sid"   : "LoggingPermissions",
              "Effect": "Allow",
              "Action": [
                  "logs:CreateLogGroup",
                  "logs:CreateLogStream",
                  "logs:PutLogEvents"
              ],
              "Resource": [
                  "arn:aws:logs:*:*:*"
              ]
          }
      ]
}
EOF
}

resource "aws_iam_policy_attachment" "lambda" {
  name       = "${var.name}-iam-policy-attachment"
  roles      = [aws_iam_role.lambda.name]
  policy_arn = aws_iam_policy.lambda_policy.arn
}
