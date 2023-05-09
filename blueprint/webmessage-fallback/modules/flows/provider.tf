terraform {
  cloud {
    organization = "thoughtmechanix"

    workspaces {
      name = "fallback_webmessenger"
    }
  }
  required_providers {

    genesyscloud = {
      source = "mypurecloud/genesyscloud"
    }
  }
}
