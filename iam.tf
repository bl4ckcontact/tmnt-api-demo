resource "aws_iam_role" "iam_lambda_role" {
  name = "tmnt-lambda-role"
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

resource "aws_iam_role_policy" "iam_dynamodb_role_policy" {
  name = "tmnt-dynamodb-role-policy"
  role = aws_iam_role.iam_lambda_role.name
  policy = <<EOF
{
	"Version": "2012-10-17",
	"Statement": [{
			"Effect": "Allow",
			"Action": [
				"dynamodb:BatchGetItem",
				"dynamodb:GetItem",
				"dynamodb:Query",
				"dynamodb:Scan",
				"dynamodb:BatchWriteItem",
				"dynamodb:PutItem",
				"dynamodb:UpdateItem"
			],
			"Resource": "arn:aws:dynamodb:${var.aws_region}:${var.aws_account_id}:table/tmnt-demo"
		}
	]
}
EOF
}

# Give the dynamodb role access to the kms key
resource "aws_iam_role_policy" "iam_kms_role_policy" {
  name = "tmnt-kms-role-policy"
  role = aws_iam_role.iam_lambda_role.name
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [{
      "Effect": "Allow",
      "Action": [
        "kms:Decrypt",
        "kms:Encrypt",
        "kms:GenerateDataKey",
        "kms:ReEncrypt*",
        "kms:DescribeKey"
      ],
      "Resource": "arn:aws:kms:${var.aws_region}:${var.aws_account_id}:key/${aws_kms_key.tmnt_demo_kms_key.id}"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "iam_lambda_role_policy_attachment" {
  role = aws_iam_role.iam_lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role" "iam_api_gateway_role" {
  name = "tmnt-api-gateway-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "apigateway.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}
