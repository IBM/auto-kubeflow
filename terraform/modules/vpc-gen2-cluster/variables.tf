variable "ibmcloud_api_key" {
  description = "IBM Cloud API key when run standalone"
}

variable "flavor" {
  default = "bx2.2x8"
}

variable "worker_count" {
  default = "1"
}

variable "region" {
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

variable "resource_group" {
  default = "default"
  type    = string
}

variable "cluster_name" {
  default = "mytestcluster"
}

variable "kube_version" {
  default     = "1.19.9"
  type        = string
  description = "kubernetes version"
}

variable "cluster_wait_til" {
  default     = "IngressReady"
  type        = string
  description = "wait until the cluster creation is in the specific stage. one of IngressReady, OneWorkerNodeReady and MasterNodeReady"
}

variable "name_suffix" {
  default     = ""
  type        = string
  description = "suffix for all of the resources that would be created"
}
