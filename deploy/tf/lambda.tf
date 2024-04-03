data "aws_iam_policy_document" "assume_role" {
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

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "../../site/api/lambdas/main.py"
  output_path = "../site/api/lambdas/main.zip"
}

resource "aws_lambda_function" "ivy_lambda_main" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = "../site/api/lambdas/main.zip"
  function_name = "main"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "index.test"
 
  # depends_on = [ 
  #   aws_vpc.ivy_vpc, 
  #   aws_subnet.lambda_subnet,
  #   aws_security_group.lambda_http
  # ]

  # vpc_config {
  #   subnet_ids = [ aws_subnet.lambda_subnet.id ]
  #   security_group_ids = [ aws_security_group.lambda_http.id ]
  # }

  source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = local.py_version

  environment {
    variables = {
      BUILD_ID = local.build_id
    }
  }
}

resource "aws_lambda_function_url" "main_url" {
  authorization_type = "NONE"
  function_name = aws_lambda_function.ivy_lambda_main.function_name
}
