provider "ibm" {
  region = var.ibm_region
  ibmcloud_api_key = var.ibmcloud_api_key
  version = ">= 1.5.3"
}
module "appid" {
  source               = "./appid"
  location             = var.ibm_region
  name                 = var.appid_name
  plan                 = var.appid_plan
}