variable "ibmcloud_api_key" {
  description = "IBM Cloud API key when run standalone"
}
variable region {
  type    = string
  default = "us-south"
}

variable org {
  type        = string
  description = "The orgnization in IBM Cloud"
}

variable space {
  type        = string
  description = "The space in IBM Cloud"
}

variable kube_version {
  type        = string
  default     = "1.20.7"
  description = "kubectl version"
}

variable resource_group {
  type        = string
  default     = "default"
  description = "The resource group in IBM Cloud"
}

variable appid_name {
  type        = string
  description = "Instnace name for AppID service"
}

variable appid_login_logo {
  type        = string
  default     = "https://avatars.githubusercontent.com/u/33164907?s=200&v=4"
  description = "The logo image of the AppID login page. Need to be a png image"
}

variable cluster_name {
  type        = string
  description = "cluster name"
}

variable "username" {
  type        = string
  description = "username to login kubeflow dashboard"
}

variable "password" {
  type        = string
  description = "password to login kubeflow dashboard"
}
