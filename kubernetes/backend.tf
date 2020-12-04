terraform {
  required_version = "0.14.0"

  backend "pg" {}

  #backend "s3" {
  #  bucket         = "374012539393-terraform-state"
  #  key            = "terraform.tfstate"
  #  region         = "us-east-1"
  #  #dynamodb_table = "terraform_state"
  #}

  required_providers {
    aws = {
      version = "3.19.0"
    }
    vault = {
      version = "2.16.0"
    }
    helm = {
      version = "1.3.2"
    }
    kubernetes = {
      version = "1.13.3"
    }
    random = {
      version = "3.0.0"
    }
    local = {
      version = "2.0.0"
    }
    null = {
      version = "3.0.0"
    }
    template = {
      version = "2.2.0"
    }
  }

}
