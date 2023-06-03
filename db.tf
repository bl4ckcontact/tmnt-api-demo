resource "aws_dynamodb_table_item" "dynamodb-tmnt-table-item-donatello" {
  table_name = aws_dynamodb_table.dynamodb-tmnt-table.name
  hash_key   = aws_dynamodb_table.dynamodb-tmnt-table.hash_key
  range_key  = aws_dynamodb_table.dynamodb-tmnt-table.range_key
  item = <<ITEM
{
  "type": {"S": "character"},
  "name": {"S": "Donatello"},
  "character_type": {"S": "hero"},
  "species": {"S": "Mutant Turtle"},
  "age": {"N": "16"},
  "bandana_color": {"S": "purple"},
  "height_in": {"N": "62"},
  "weight_lbs": {"N": "180"}
}
ITEM
}

resource "aws_dynamodb_table_item" "dynamodb-tmnt-table-item-leonardo" {
  table_name = aws_dynamodb_table.dynamodb-tmnt-table.name
  hash_key   = aws_dynamodb_table.dynamodb-tmnt-table.hash_key
  range_key  = aws_dynamodb_table.dynamodb-tmnt-table.range_key
  item = <<ITEM
{
  "type": {"S": "character"},
  "name": {"S": "Leonardo"},
  "character_type": {"S": "hero"},
  "species": {"S": "Mutant Turtle"},
  "age": {"N": "16"},
  "bandana_color": {"S": "blue"},
  "height_in": {"N": "62"},
  "weight_lbs": {"N": "180"}
}
ITEM
}

resource "aws_dynamodb_table_item" "dynamodb-tmnt-table-item-michaelangelo" {
  table_name = aws_dynamodb_table.dynamodb-tmnt-table.name
  hash_key   = aws_dynamodb_table.dynamodb-tmnt-table.hash_key
  range_key  = aws_dynamodb_table.dynamodb-tmnt-table.range_key
  item = <<ITEM
{
  "type": {"S": "character"},
  "name": {"S": "Michelangelo"},
  "character_type": {"S": "hero"},
  "species": {"S": "Mutant Turtle"},
  "age": {"N": "16"},
  "bandana_color": {"S": "orange"},
  "height_in": {"N": "62"},
  "weight_lbs": {"N": "180"}
}
ITEM
}

resource "aws_dynamodb_table_item" "dynamodb-tmnt-table-item-raphael" {
  table_name = aws_dynamodb_table.dynamodb-tmnt-table.name
  hash_key   = aws_dynamodb_table.dynamodb-tmnt-table.hash_key
  range_key  = aws_dynamodb_table.dynamodb-tmnt-table.range_key
  item = <<ITEM
{
  "type": {"S": "character"},
  "name": {"S": "Raphael"},
  "character_type": {"S": "hero"},
  "species": {"S": "Mutant Turtle"},
  "age": {"N": "16"},
  "bandana_color": {"S": "red"},
  "height_in": {"N": "62"},
  "weight_lbs": {"N": "180"}
}
ITEM
}

resource "aws_dynamodb_table_item" "dynamodb-tmnt-table-item-splinter" {
  table_name = aws_dynamodb_table.dynamodb-tmnt-table.name
  hash_key   = aws_dynamodb_table.dynamodb-tmnt-table.hash_key
  range_key  = aws_dynamodb_table.dynamodb-tmnt-table.range_key
  item = <<ITEM
{
  "type": {"S": "character"},
  "name": {"S": "Splinter"},
  "character_type": {"S": "goodguy"},
  "species": {"S": "Mutant Turtle"},
  "age": {"N": "50"},
  "bandana_color": {"S": "red"},
  "height_in": {"N": "58"},
  "weight_lbs": {"N": "140"}
}
ITEM
}

resource "aws_dynamodb_table_item" "dynamodb-tmnt-table-item-shredder" {
  table_name = aws_dynamodb_table.dynamodb-tmnt-table.name
  hash_key   = aws_dynamodb_table.dynamodb-tmnt-table.hash_key
  range_key  = aws_dynamodb_table.dynamodb-tmnt-table.range_key
  item = <<ITEM
{
  "type": {"S": "character"},
  "name": {"S": "Shredder"},
  "character_type": {"S": "badguy"},
  "species": {"S": "Mutant Turtle"},
  "age": {"N": "50"},
  "bandana_color": {"S": "red"},
  "height_in": {"N": "74"},
  "weight_lbs": {"N": "240"}
}
ITEM
}

resource "aws_dynamodb_table" "dynamodb-tmnt-table" {
  name           = "tmnt-demo"
  billing_mode   = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "type"
  range_key      = "name"

  attribute {
    name = "type"
    type = "S"
  }

  attribute {
    name = "name"
    type = "S"
  }

}
