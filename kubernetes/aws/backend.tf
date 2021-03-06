terraform {
  required_version = "0.14.5"

  #backend "pg" {}

  #backend "s3" {
  #  bucket         = "374012539393-terraform-state"
  #  key            = "terraform.tfstate"
  #  region         = "us-east-1"
  #  #dynamodb_table = "terraform_state"
  #}

  required_providers {
    aws = {
      version = "3.25.0"
    }
    vault = {
      version = "2.18.0"
    }
    helm = {
      version = "2.0.2"
    }
    kubernetes = {
      version = "2.0.1"
    }
    random = {
      version = "3.0.1"
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
