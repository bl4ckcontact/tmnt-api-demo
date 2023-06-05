output "aws_lambda_function_invoke_arn" {
  value = "${aws_lambda_function.tmnt_api.invoke_arn}"
  description = "ARN to invoke the lambda function"
}

output "aws_kms_key_arn" {
  value = "${aws_kms_key.tmnt_demo_kms_key.arn}"
  description = "ARN of the KMS key used to encrypt the demo resources"
}