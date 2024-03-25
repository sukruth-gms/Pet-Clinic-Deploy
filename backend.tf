locals {
  lock_id = uuid()
}

terraform {
  backend "s3" {
    bucket         = "pc-remotestate-1"
    key            = "default/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "pet-state-locking"
    encrypt        = "true"
  }
}
