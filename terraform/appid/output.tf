output "appid_id" {
  value = ibm_resource_instance.appid_instance.id
}

output "clientId" {
  value = ibm_resource_key.resource_key.credentials["clientId"]
}

output "secret" {
  value = ibm_resource_key.resource_key.credentials["secret"]
}

output "discoveryEndpoint" {
  value = ibm_resource_key.resource_key.credentials["discoveryEndpoint"]
}

output "tenantId" {
  value = ibm_resource_key.resource_key.credentials["tenantId"]
}

output "managementUrl" {
  value = ibm_resource_key.resource_key.credentials["managementUrl"]
}

output "oauthServerUrl" {
  value = ibm_resource_key.resource_key.credentials["oauthServerUrl"]
}
