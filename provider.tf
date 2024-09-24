terraform {
  required_providers {
    aws = {
      version = "~> 5.52.0"
    }
  }
}

# If you authentificate using your aws creds  use the below block
# provider "aws" {
#   access_key = ""
#   secret_key = ""
#   region     = var.region
# }

# If you authentificate using your aws cli use the below block
provider "aws" {
  region     = var.region
}