terraform {
  backend "s3" {
    bucket         = "statefile-bucketgibs"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "state-locking"
  }
}