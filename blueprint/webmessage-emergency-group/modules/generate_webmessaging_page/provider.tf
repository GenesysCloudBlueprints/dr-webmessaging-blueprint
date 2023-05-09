terraform {
  cloud {
    organization = "thoughtmechanix"

    workspaces {
      name = "prod-webmessenger"
  }
  required_providers {

    genesyscloud = {
      source = "mypurecloud/genesyscloud"
    }
  }
}
