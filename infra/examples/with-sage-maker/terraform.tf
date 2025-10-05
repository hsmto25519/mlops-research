terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6"
    }
    http = {
      source  = "hashicorp/http"
      version = ">= 3"
    }
  }
  required_version = ">= 1.0"

  backend "local" {
  }
}
