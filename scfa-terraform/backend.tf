terraform {
 backend "s3" {
  bucket         = "scfa-dev-tfstate"
  key            = "terraform.tfstate"   
  region         = "us-east-1"
  dynamodb_table = "scfa-dev-tf-locks"
  encrypt        = true
}
}
