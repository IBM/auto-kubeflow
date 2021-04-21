output "vpc_id" {
  value = ibm_is_vpc.vpc.id
}

output "subnet_id" {
  value = ibm_is_subnet.subnet.id
}

output "cluster_id" {
  value = ibm_container_vpc_cluster.cluster.id
}

output "cluster_hostname" {
  value = ibm_container_vpc_cluster.cluster.ingress_hostname
}

output "cluster_secret" {
  value = ibm_container_vpc_cluster.cluster.ingress_secret
}

output "cluster_name" {
  value = "${var.cluster_name}${var.name_suffix}"
}