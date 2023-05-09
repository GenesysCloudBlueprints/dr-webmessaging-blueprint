resource "genesyscloud_integration_action" "create_callback_data_action" {
    name           = "DR Create Callback "
    category       = "DR Callbacks"
    integration_id = var.genesyscloud_integration_id
   
    contract_input  = jsonencode({
        "type": "object",
        "properties": {
          "queueId": {
            "type": "string"
          },
          "phone": {
            "type": "string"
          },
          "message": {
            "type": "string"
          },
          "callerName": {
            "type": "string"
          },
          "callerIdName": {
            "type": "string"
          },
           "callbackUserName": {
            "type": "string"
          }
        },
        "additionalProperties": true
      })
    contract_output = jsonencode({
       "type": "object",
        "properties": {},
        "additionalProperties": true
    })
    
    config_request {
        request_template     = "{\n\"callbackUserName\":\"$${input.callbackUserName}\",\n\"callerIdName\":\"$${input.callerIdName}\",\n\"callbackNumbers\": [ \"$${input.phone}\" ],\n\"data\":{\"message\":\"$${input.message}\"},\n\"routingData\": {\n\"queueId\": \"$${input.queueId}\"\n}\n}"
        request_type         = "POST"
        request_url_template = "/api/v2/conversations/callbacks"
    }

    config_response {
        success_template = "$${rawResult}"
    }
}