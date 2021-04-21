output "cluster_id" {
  value = ibm_container_cluster.cluster.id
}

output "cluster_hostname" {
  value = ibm_container_cluster.cluster.ingress_hostname
}

output "cluster_secret" {
  value = ibm_container_cluster.cluster.ingress_secret
}

output "cluster_name" {
  value = "${var.cluster_name}${var.name_suffix}"
}