
/*
   Creates the queues used within the flow
*/
module "my_message_queues" {
  source                   = "git::https://github.com/GenesysCloudDevOps/genesys-cloud-queues-demo.git?ref=main"
  classifier_queue_names   = ["mychat-life-insurance","mychat-life-annuity","mychat-mutual-funds","mychat-brokerage","mychat-health-insurance","mychat-general-help","mychat-cancellations", "mychat-general-support"]
  classifier_queue_members = []
}

/*   
   Creates the bot flow and inbound chat flow
*/
module "my_chat_flow" {
  source      = "./modules/flows"
}

/*   
   Configures the widget deployment
*/
module "webmessaging_deploy" {
  source      = "./modules/web_deployment"
  environment = var.environment
  prefix      = var.prefix
  flowId      = module.my_chat_flow.flow_id
}

/*Generates an html page containing the webmessaging widget*/
module "webmessaging_widget_page" {
  depends_on                             = [module.webmessaging_deploy]
  source                                 = "./modules/generate_webmessaging_page"
  genesyscloud_scripting_env             = var.genesysCloudScriptEnv
  genesyscloud_scripting_url             = var.genesysCloudScriptUrl
  genesyscloud_webmessaging_deploymentid = module.webmessaging_deploy.webmessenger_deploymentid
}

resource "genesyscloud_architect_emergencygroup" "site_evac_emergency_group" {
  name        = "My Organization Evacuation Emergency Group"
  description = "Emergency Group to activate emergency ivr"
}

module "genesys_cloud_public_api_integration" {
    source = "git::https://github.com/GenesysCloudDevOps/public-api-data-actions-integration-module.git?ref=main"

    integration_name                = "GC Data Actions Public API"
    integration_creds_client_id     = var.integration_creds_client_id
    integration_creds_client_secret = var.integration_creds_client_secret
}

module "genesyscloud_callback_action" {
  source                                 = "./modules/callback_action"
  depends_on                             = [module.genesys_cloud_public_api_integration]
  genesyscloud_integration_id = module.genesys_cloud_public_api_integration.integration_id
}

