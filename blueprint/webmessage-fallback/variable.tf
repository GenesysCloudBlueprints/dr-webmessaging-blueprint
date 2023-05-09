variable "prefix" {
  type        = string
  description = "A name that is to be used as the resource name prefix. Usually it's the project name."
}

variable "environment" {
  type        = string
  description = "Name of the environment, e.g., dev, test, stable, staging, uat, prod etc."
}

variable "genesysCloudScriptEnv" {
  type        = string
  description = "Short hand code for AWS Genesys Cloud Web Messaging scripting region (e.g. mypurecloud,usw2, cac1)"
}

variable "genesysCloudScriptUrl" {
  type        = string
  description = "Genesys Cloud Apps URL.  See https://developer.genesys.cloud/api/rest/ for a complete list of apps URLs."
}


variable "integration_creds_client_id" {
  type        = string
  description = "Client credential id for the Callback data action"
}

variable "integration_creds_client_secret" {
  type        = string
  description = "Client credential secret for the Callback data action"
}

