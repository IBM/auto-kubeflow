resource "ibm_resource_instance" "appid_instance" {
  name     = var.name
  service  = "appid"
  plan     = var.plan
  location = var.location
}

resource "ibm_iam_service_id" "appid_serviceid" {
  name        = "serviceid_4_appid"
  description = "service id for appid"
}

resource "ibm_resource_key" "resource_key" {
  name                 = "manager_credentials"
  role                 = "Manager"
  resource_instance_id = ibm_resource_instance.appid_instance.id
  parameters = {
    serviceid_crn = ibm_iam_service_id.appid_serviceid.crn
  }
}

