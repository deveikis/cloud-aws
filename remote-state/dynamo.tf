resource "aws_dynamodb_table" "tf-rlock" {
  name         = var.dynamodb_table_name
  billing_mode = var.dynamodb_table_billing_mode
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  server_side_encryption {
    enabled     = var.dynamodb_enable_server_side_encryption
    kms_key_arn = aws_kms_key.tf-rstate.arn
  }

  point_in_time_recovery {
    enabled = true
  }

  tags = var.tags
}
