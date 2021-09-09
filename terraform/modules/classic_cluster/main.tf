terraform {
  required_providers {
    ibm = {
      source = "IBM-Cloud/ibm"
      version = "1.29.0"
    }
  }
}

data "ibm_resource_group" "resource_group" {
  name = var.resource_group
}

# resource "ibm_network_vlan" "public_vlan" {
#   count       = local.public_vlan_count
#   name        = "public_vlan${var.name_suffix}"
#   datacenter  = var.datacenter
#   type        = "PUBLIC"
# }

# resource "ibm_network_vlan" "private_vlan" {
#   count       = local.private_vlan_count
#   name        = "private_vlan${var.name_suffix}"
#   datacenter  = var.datacenter
#   type        = "PRIVATE"
# }

resource "ibm_container_cluster" "cluster" {
  name              = "${var.cluster_name}${var.name_suffix}"
  datacenter        = var.datacenter
  default_pool_size = var.worker_count
  kube_version      = var.kube_version
  resource_group_id = data.ibm_resource_group.resource_group.id
  machine_type      = var.flavor
  public_vlan_id    = var.public_vlan_id
  private_vlan_id   = var.private_vlan_id
  hardware          = "shared"
}

