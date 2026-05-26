terraform {
    required_version = ">=1.5"
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 5.0"
        }
    }
    backend "s3" {
        bucket = "terraform-state-devops-jouiniyed"
        key = "k3s/terraform.tfstate"
        region = "eu-west-3"
        encrypt = true 
    }

}

provider "aws" {
  region = var.aws_region
}



