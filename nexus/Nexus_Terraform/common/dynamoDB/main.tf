resource "aws_dynamodb_table" "pib_terraform_locks" {
  name         = "pib-locks-for-state"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}
