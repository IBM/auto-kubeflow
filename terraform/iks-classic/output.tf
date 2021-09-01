output "appid_id" {
  value = module.appid.appid_id
}

output "appid_discoveryEndpoint" {
  value = module.appid.discoveryEndpoint
  sensitive = true
}

output "appid_tenantId" {
  value = module.appid.tenantId
  sensitive = true
}

output "appid_managementUrl" {
  value = module.appid.managementUrl
  sensitive = true
}

output "appid_oauthServerUrl" {
  value = module.appid.oauthServerUrl
  sensitive = true
}

output "cluster_id" {
  value = module.classic_cluster.cluster_id
}

output "cluster_name" {
  value = module.classic_cluster.cluster_name
}

output "cluster_hostname" {
  value = module.classic_cluster.cluster_hostname
}
