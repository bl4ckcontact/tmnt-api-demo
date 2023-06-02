# module "iam_user" {
#   source = "terraform-aws-modules/iam/aws//modules/iam-user"
#   name = "tmnt-svc-user"

#   create_user = true
#   force_destroy = true
#   iam_access_key_status = "Active"
#   tags = {
#     Environment = "dev"
#     Application = "tmnt"
#   }
# }

resource "aws_iam_role" "iam_lambda_exec" {
  name = "tmnt-lambda-exec-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "iam_lambda_exec" {
  role = aws_iam_role.iam_lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

