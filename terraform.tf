terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.23.0"
    }
  }
  cloud {
    organization = "tflogan"
    workspaces {
      name = "sudoku"
    }
  }
}

provider "aws" {
  region = "ap-southeast-2"
}

provider "aws" {
  alias  = "global"
  region = "us-east-1"
}
