resource "genesyscloud_flow" "deploy_archy_flow_bot" {
  filepath = "${path.module}/MyChatBot.yaml"
  file_content_hash = filesha256("${path.module}/MyChatBot.yaml") 
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
  file_content_hash = filesha256("${path.module}/MyWebMessenger.yaml") 
  substitutions = {
    flow_name           = "MyWebMessenger"
    force_unlock        = true
    default_language    = "en-us"
  }
}

resource "genesyscloud_flow" "deploy_archy_flow_emergency_bot" {
  filepath = "${path.module}/MyEmergencyChatBot.yaml"
  file_content_hash = filesha256("${path.module}/MyEmergencyChatBot.yaml") 
}