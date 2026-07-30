terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.56.0"
    }
  }

  backend "s3" {
    bucket = "cicd-bucket-estudos"
    key    = "cicd-state/terraform.tfstate"
  }
}

provider "aws" {
  region  = var.region
  profile = var.profile
}


resource "aws_s3_bucket" "cicd_bucket" {
  bucket        = "cicd-bucket-estudos"
  force_destroy = true

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Iac = "true"
  }

}


resource "aws_s3_bucket_versioning" "cicd_bucket_versioning" {
  bucket = "cicd-bucket-estudos"

  versioning_configuration {
    status = "Enabled"
  }

}
