terraform {
  required_version = "0.14.0"

  backend "pg" {}

  #backend "s3" {
  #  bucket         = "374012539393-terraform-state"
  #  key            = "terraform.tfstate"
  #  region         = "us-east-1"
  #  #dynamodb_table = "terraform_state"
  #}

}
