terraform {
  cloud {
    organization = "thoughtmechanix"

    workspaces {
      name = "prod-webmessenger"
    }
  }
  required_providers {
    archive = {
      version = ">= 2.0"
      source  = "hashicorp/archive"
    }

    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }

    genesyscloud = {
      source = "mypurecloud/genesyscloud"
    }
  }
}

provider "genesyscloud" {
}
