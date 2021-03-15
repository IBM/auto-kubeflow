terraform {
  required_providers {
    ibm = {
      source = "IBM-Cloud/ibm"
      version = "1.21.2"
    }
  }
}

provider "ibm" {
  # Configuration options
  region = var.region
  ibmcloud_api_key = var.ibmcloud_api_key
}

locals {
  callback_uri = "https://kfp.example.com/callback"
}
module "appid" {
  source               = "./appid"
  ibmcloud_api_key     = var.ibmcloud_api_key
  region               = var.region
  name                 = var.appid_name
  plan                 = var.appid_plan
}

resource "null_resource" "ansible" {
  triggers = {
    always_run = timestamp()
  }

  # provisioner "local-exec" {
  #   command = "ansible-galaxy install -p ${path.module}/ansible/roles andrewrothstein.kubectl"
  # }

  provisioner "ansible" {
    plays {
      playbook {
        file_path  = "${path.module}/ansible/site.yml"
        roles_path = [ "${path.module}/ansible/roles"]
      }
      inventory_file = "${path.module}/ansible/inventory.yml"
      verbose = true
      extra_vars = {
        ibmcloud_api_key = var.ibmcloud_api_key
        region           = var.region
        org              = var.org
        space            = var.space
        resource_group   = var.resource_group
        appid_clientId   = module.appid.clientId
        appid_id         = module.appid.appid_id
        kubectl_ver      = var.kubectl_ver
        appid_mgmt_url   = module.appid.managementUrl
        callback_uri     = local.callback_uri
      }
    }
  }
  depends_on = [module.appid]
}