resource "aws_dynamodb_table" "pet_state_locking-1" {
  name           = "pet-state-locking-1"
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
    Name = "pet-state-locking-1"
  }
}
