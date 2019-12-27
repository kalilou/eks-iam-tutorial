provider "aws" {
  region              = "eu-north-1"
  version             = "2.43.0"
}

terraform {
  required_version =  "> 0.12.0"

  backend "s3" {
    bucket   = "eks-iam-example-revolight"
    key      = "eks-iam.state"
    region   = "eu-north-1"
  }
}

locals {
  subnet_ids = [
    "subnet-***REDACTED***",
    "subnet-***REDACTED***",
    "subnet-***REDACTED***"
  ]
}
