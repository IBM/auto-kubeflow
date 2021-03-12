variable "ibmcloud_api_key" {
  description = "IBM Cloud API key when run standalone"
}
variable ibm_region {
  type=string
  default="us-south"
}

variable appid_plan {
  type=string
  default="lite"
  description="plan for AppID"
}

variable appid_name {
  type=string
  default="appid-instance"
  description="Instnace name for AppID service"
}
