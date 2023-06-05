# module "lambda" {
#   source                            = "./lambda"
#   aws_account_id                    = var.aws_account_id
#   aws_region                        = var.aws_region
#   aws_api_gateway_rest_api          = aws_api_gateway_rest_api.tmnt_api
#   aws_api_gateway_method            = aws_api_gateway_method.any
#   aws_api_gateway_resource_turtles  = aws_api_gateway_resource.turtles
# }