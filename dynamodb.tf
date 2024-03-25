resource "aws_dynamodb_table" "pet_state_locking" {
  name           = "pet-state-locking"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"
  range_key      = "LockCreatedAt"
  
  attribute {
    name = "LockID"
    type = "S"  # Assuming LockID is a string
  }
  
  attribute {
    name = "LockCreatedAt"
    type = "N"  # Assuming LockCreatedAt is a number (epoch timestamp)
  }
  
  tags = {
    Name = "pet-state-locking"
  }
}
