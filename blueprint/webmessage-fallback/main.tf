/*
   Creates an emergency group users can be assigned to
*/   
resource "genesyscloud_group" "emergency_group" {
  name          = "Emergency Group"
  description   = "Emergency Group for supervisors to answer calls in an emergency"
  type          = "official"
  visibility    = "public"
  member_ids= [data.genesyscloud_user.admin_user.id ]
}
/*
   Creates the queues used within the flow
*/
resource "genesyscloud_routing_queue" "mychat-general-help" {
  name                              = "mychat-general-help"
  description                       = "General Help Queue"
  acw_wrapup_prompt                 = "MANDATORY_TIMEOUT"
  acw_timeout_ms                    = 300000
  skill_evaluation_method           = "BEST"
  auto_answer_only                  = true
  enable_transcription              = true
  enable_manual_assignment          = true

  media_settings_call {
    alerting_timeout_sec      = 30
    service_level_percentage  = 0.7
    service_level_duration_ms = 10000
  }
  routing_rules {
    operator     = "MEETS_THRESHOLD"
    threshold    = 9
    wait_seconds = 300
  }

   groups= [genesyscloud_group.emergency_group.id]
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

