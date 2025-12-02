resource "aws_lambda_function" "fn" {
  function_name = var.subdomain_name
  package_type  = "Image"
  image_uri     = "${aws_ecr_repository.lambda_repo.repository_url}:latest"
  role          = aws_iam_role.lambda_role.arn
}

resource "aws_lambda_function_url" "fn_url" {
  function_name      = aws_lambda_function.fn.function_name
  authorization_type = "NONE"
}

resource "aws_iam_role" "lambda_role" {
  name = var.subdomain_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = { Service = "lambda.amazonaws.com" },
      Action    = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_basic" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_permission" "public_invoke_url" {
  statement_id           = "AllowPublicInvokeURL"
  action                 = "lambda:InvokeFunctionUrl"
  function_name          = aws_lambda_function.fn.function_name
  principal              = "*"
  function_url_auth_type = "NONE"
}
