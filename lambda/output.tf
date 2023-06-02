output "aws_lambda_function_invoke_arn" {
  value = "${aws_lambda_function.tmnt_api.invoke_arn}"
  description = "ARN to invoke the lambda function"
}