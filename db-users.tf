# resource "aws_dynamodb_table_item" "dynamodb-tmnt-table-item-shredder" {
#   table_name = aws_dynamodb_table.dynamodb-tmnt-table.name
#   hash_key   = aws_dynamodb_table.dynamodb-tmnt-table.hash_key
#   range_key  = aws_dynamodb_table.dynamodb-tmnt-table.range_key
#   item = <<ITEM
# {
#   "type": {"S": "character"},
#   "name": {"S": "Shredder"},
#   "character_type": {"S": "badguy"},
#   "species": {"S": "Mutant Human"},
#   "age": {"N": "50"},
#   "height_in": {"N": "74"},
#   "weight_lbs": {"N": "240"}
# }
# ITEM
# }

# resource "aws_dynamodb_table" "dynamodb-tmnt-table" {
#   name           = "tmnt-demo-users"
#   billing_mode   = "PAY_PER_REQUEST"
#   read_capacity  = 1
#   write_capacity = 1
#   hash_key       = "userID"

#   point_in_time_recovery {
#     enabled = true
#   }

#   server_side_encryption {
#     enabled = true
#     kms_key_arn = aws_kms_key.tmnt_demo_kms_key.arn
#   }

#   attribute {
#     name = "userID"
#     type = "S"
#   }
# }
