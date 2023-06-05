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
  "species": {"S": "Mutant Rat"},
  "age": {"N": "50"},
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
  "species": {"S": "Mutant Human"},
  "age": {"N": "50"},
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

  point_in_time_recovery {
    enabled = true
  }

  server_side_encryption {
    enabled = true
    kms_key_arn = aws_kms_key.tmnt_demo_kms_key.arn
  }

  attribute {
    name = "type"
    type = "S"
  }

  attribute {
    name = "name"
    type = "S"
  }

}

resource "aws_dynamodb_table_item" "dynamodb-tmnt-table-item-location-the-sewer" {
  table_name = aws_dynamodb_table.dynamodb-tmnt-table.name
  hash_key   = aws_dynamodb_table.dynamodb-tmnt-table.hash_key
  range_key  = aws_dynamodb_table.dynamodb-tmnt-table.range_key
  item = <<ITEM
{
  "type": {"S": "location"},
  "name": {"S": "the_sewer"},
  "geographic_location": {"S": "hero"},
  "home_to": {"S": "teenage_mutant_ninja_turtles","S": "splinter"},
  "adjectives": {"S": "dark","S": "dank","S": "wet","S": "smelly"}
}
ITEM
}

resource "aws_dynamodb_table_item" "dynamodb-tmnt-table-item-location-osaka" {
  table_name = aws_dynamodb_table.dynamodb-tmnt-table.name
  hash_key   = aws_dynamodb_table.dynamodb-tmnt-table.hash_key
  range_key  = aws_dynamodb_table.dynamodb-tmnt-table.range_key
  item = <<ITEM
{
  "type": {"S": "location"},
  "name": {"S": "osaka"},
  "geographic_location": {"S": "japan"},
  "home_to": {"S": "oroku_saki","S": "the_foot_clan"},
  "adjectives": {"S": "crowded","S": "busy","S": "loud","S": "bright","S": "traditional"}
}
ITEM
}

resource "aws_dynamodb_table_item" "dynamodb-tmnt-table-item-location-new-york-city" {
  table_name = aws_dynamodb_table.dynamodb-tmnt-table.name
  hash_key   = aws_dynamodb_table.dynamodb-tmnt-table.hash_key
  range_key  = aws_dynamodb_table.dynamodb-tmnt-table.range_key
  item = <<ITEM
{
  "type": {"S": "location"},
  "name": {"S": "new_york_city"},
  "geographic_location": {"S": "united_states"},
  "home_to": {"S": "april_o_neil","S": "casey_jones","S": "teenage_mutant_ninja_turtles","S": "the_foot_clan"},
  "adjectives": {"S": "big","S": "crowded","S": "busy","S": "loud","S": "bright","S": "crime_ridden"}
}
ITEM
}