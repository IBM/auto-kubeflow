output "cluster_hostname" {
  value = data.ibm_container_cluster.cluster.ingress_hostname
}

output "cluster_name" {
  value = var.cluster_name
}
