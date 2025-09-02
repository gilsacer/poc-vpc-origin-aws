
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.4.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = ">= 4.0.0"
    }
  }
  required_version = ">= 1.0.0"
}

# Provider for us-east-1 region (required for CloudFront WAF resources)
provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}
