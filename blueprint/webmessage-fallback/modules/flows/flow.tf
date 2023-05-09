resource "genesyscloud_flow" "deploy_archy_flow_bot" {
  filepath = "${path.module}/MyChatBot.yaml"
  substitutions = {
    flow_name             = "MyChatBot"
    default_language      = "en-us"
    force_unlock          = true
  }
}

resource "genesyscloud_flow" "deploy_archy_flow_chat" {
  depends_on=[genesyscloud_flow.deploy_archy_flow_emergency_bot,
              genesyscloud_flow.deploy_archy_flow_bot]
  filepath = "${path.module}/MyWebMessenger.yaml"
  substitutions = {
    flow_name           = "MyWebMessenger"
    force_unlock        = true
    default_language    = "en-us"
    # integration_category = var.integration_category
    # integration_data_action_name = var.integration_data_action_name
  }
}

resource "genesyscloud_flow" "deploy_archy_flow_emergency_bot" {
  filepath = "${path.module}/MyEmergencyChatBot.yaml"
}