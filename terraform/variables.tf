variable "ibmcloud_api_key" {
  description = "IBM Cloud API key when run standalone"
}
variable region {
  type=string
  default="us-south"
}

variable org {
  type = string
  description = "The orgnization in IBM Cloud"
}

variable space {
  type = string
  description = "The space in IBM Cloud"
}

variable kubectl_ver {
  type = string
  default = "v1.18.15"
  description = "kubectl version"
}

variable resource_group {
  type = string
  default = "default"
  description = "The resource group in IBM Cloud"
}

variable appid_plan {
  type=string
  default="lite"
  #graduated-tier
  description="plan for AppID"
}

variable appid_name {
  type=string
  default="appid-instance"
  description="Instnace name for AppID service"
}
