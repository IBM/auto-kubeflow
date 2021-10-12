terraform {
  required_providers {
    ibm = {
      source = "IBM-Cloud/ibm"
      version = "1.29.0"
    }
  }
}

provider "ibm" {
  # Configuration options
  region = var.region
  ibmcloud_api_key = var.ibmcloud_api_key
}

locals {
  kube_version_str      = split(".", var.kube_version)
}

data "ibm_resource_group" "group" {
  name = var.resource_group
}

# get appid information
data "ibm_resource_instance" "appid_instance" {
  name     = var.appid_name
  service  = "appid"
  resource_group_id = data.ibm_resource_group.group.id
  location = var.region
}

resource "ibm_iam_service_id" "appid_serviceid" {
  name        = "serviceid_4_appid_${var.appid_name}"
  description = "service id for appid"
  depends_on = [
    data.ibm_resource_instance.appid_instance
  ]
}

resource "ibm_resource_key" "resource_key" {
  name                 = "manager_credentials_${var.appid_name}"
  role                 = "Manager"
  resource_instance_id = data.ibm_resource_instance.appid_instance.id
  parameters = {
    serviceid_crn = ibm_iam_service_id.appid_serviceid.crn
  }
}

# get cluster information
data "ibm_container_cluster" "cluster" {
  name = var.cluster_name
  resource_group_id = data.ibm_resource_group.group.id
}

data "ibm_container_cluster_config" "cluster_config" {
  cluster_name_id = data.ibm_container_cluster.cluster.id
}

resource "null_resource" "ansible" {
  triggers = {
    always_run              = timestamp()
    ibmcloud_api_key        = var.ibmcloud_api_key
    region                  = var.region
    org                     = var.org
    space                   = var.space
    resource_group          = var.resource_group
    appid_clientId          = ibm_resource_key.resource_key.credentials["clientId"]
    appid_secret            = ibm_resource_key.resource_key.credentials["secret"]
    appid_oauthServerUrl    = ibm_resource_key.resource_key.credentials["oauthServerUrl"]
    appid_id                = data.ibm_resource_instance.appid_instance.id
    appid_username          = var.username
    appid_password          = var.password
    kubectl_ver             = "v${var.kube_version}"
    appid_mgmt_url          = ibm_resource_key.resource_key.credentials["managementUrl"]
    cluster_hostname        = data.ibm_container_cluster.cluster.ingress_hostname
    cluster_name            = var.cluster_name
    secret_name             = data.ibm_container_cluster.cluster.ingress_secret
    kube_config             = data.ibm_container_cluster_config.cluster_config.config_file_path
    kubeflow_logo_uri       = var.appid_login_logo
  }

  provisioner "ansible" {
    plays {
      playbook {
        file_path  = "${path.module}/../ansible/multi-user-classic.yml"
        roles_path = [ "${path.module}/../ansible/roles"]
      }
      inventory_file = "${path.module}/../ansible/inventory.yml"
      verbose = true
      extra_vars = {
        ibmcloud_api_key        = var.ibmcloud_api_key
        region                  = var.region
        org                     = var.org
        space                   = var.space
        resource_group          = var.resource_group
        appid_clientId          = ibm_resource_key.resource_key.credentials["clientId"]
        appid_secret            = ibm_resource_key.resource_key.credentials["secret"]
        appid_oauthServerUrl    = ibm_resource_key.resource_key.credentials["oauthServerUrl"]
        appid_id                = data.ibm_resource_instance.appid_instance.id
        appid_username          = var.username
        appid_password          = var.password
        kubectl_ver             = "v${var.kube_version}"
        appid_mgmt_url          = ibm_resource_key.resource_key.credentials["managementUrl"]
        cluster_hostname        = data.ibm_container_cluster.cluster.ingress_hostname
        cluster_name            = var.cluster_name
        secret_name             = data.ibm_container_cluster.cluster.ingress_secret
        kube_config             = data.ibm_container_cluster_config.cluster_config.config_file_path
        kubeflow_logo_uri       = var.appid_login_logo
      }
    }
  }

  provisioner "ansible" {
    when    = destroy
    plays {
      playbook {
        file_path  = "${path.module}/../ansible/multi-user-classic-destroy.yml"
        roles_path = [ "${path.module}/../ansible/roles"]
      }
      inventory_file = "${path.module}/../ansible/inventory.yml"
      verbose = true
      extra_vars = {
        ibmcloud_api_key        = self.triggers.ibmcloud_api_key
        region                  = self.triggers.region
        org                     = self.triggers.org
        space                   = self.triggers.space
        resource_group          = self.triggers.resource_group
        appid_clientId          = self.triggers.appid_clientId
        appid_secret            = self.triggers.appid_secret
        appid_oauthServerUrl    = self.triggers.appid_oauthServerUrl
        appid_id                = self.triggers.appid_id
        appid_username          = self.triggers.appid_username
        appid_password          = self.triggers.appid_password
        kubectl_ver             = self.triggers.kubectl_ver
        appid_mgmt_url          = self.triggers.appid_mgmt_url
        cluster_hostname        = self.triggers.cluster_hostname
        cluster_name            = self.triggers.cluster_name
        secret_name             = self.triggers.secret_name
        kube_config             = self.triggers.kube_config
        kubeflow_logo_uri       = self.triggers.kubeflow_logo_uri
      }
    }
  }

  depends_on = [data.ibm_container_cluster.cluster, data.ibm_container_cluster_config.cluster_config]
}

