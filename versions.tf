# Cette configuration Terraform spécifie la version minimale de Terraform requise et les fournisseurs nécessaires pour le projet.
terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.34.0"
    }
    local = {
      source  = "hashicorp/local"
      version = ">= 2.7.0"
    }
    random = {
      source = "hashicorp/random"
      version = ">= 3.8.1"
    } 
  }
}

# Configuration du fournisseur AWS
provider "aws" {
  region = "eu-west-3" # Spécifiez la région AWS souhaitée
}

provider "aws" {
    alias  = "eu_central_1"
    region = "eu-central-1" # Spécifiez une autre région AWS si nécessaire
}