provider "aws" {
  region = "eu-west-1"
}

terraform {
  required_version = "1.1.9"

  required_providers {
    aws = "4.12.1"
  }

  backend "s3" {
    bucket = "runninginstancesreport"
    key      = "terraform/runninginstancesreport.tfstate"
    region   = "eu-west-1"
  }
}
