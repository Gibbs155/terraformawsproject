#Policy Creating for Lambda Role 
resource "aws_iam_role" "api_role" {
  name               = var.lambda_role_name
  assume_role_policy = file(var.assume_role_policy)
}

resource "aws_iam_role_policy" "api_policy" {
  name   = var.lambda_policy_name
  role   = aws_iam_role.api_role.id
  policy = file(var.policy)
}

#Policy Creating for Api Gateway
resource "aws_iam_role" "apigateway_role" {
  name               = var.api_role_name
  assume_role_policy = file(var.api_assume_role_policy)
}

resource "aws_iam_role_policy" "apigateway_policy" {
  name   = var.api_policy_name
  role   = aws_iam_role.apigateway_role.id
  policy = file(var.api_policy)
}