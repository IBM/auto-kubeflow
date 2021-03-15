variable "ibmcloud_api_key" {
  description = "IBM Cloud API key when run standalone"
}

variable region {
  type=string
  default="us-south"
}

variable plan {
  type=string
  default="lite"
}

variable name {
  type=string
  default="test-instance"
}
