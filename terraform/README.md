# auto-kubeflow
Use Schematics/Terraform + Ansible to create a IKS cluster on IBM Cloud,
deploy kubeflow multi-user and integrate it with AppID service.

The terraform templates are used to create IKS cluster as well as AppID
instance. The kubeflow deployment and configuration are done by Ansible
playbook under `ansible` directory. It uses
[Ansible provisioner](https://github.com/radekg/terraform-provisioner-ansible)
to perform Ansilbe playbook.

Note: The Ansible playbook under `asnible` directory assumes the execution
environment is Linux x86_64 architecture. If you want to run it locally, you may need
to modify the playbook to accommodate your own environment.

# IBM Kubernetes Cluster (IKS)
On IBM Cloud, you can create IKS on classic, VPC worker nodes or OpenShift.
Each configuration needs different terraform scripts.
- VPC Gen2: [iks-vpc-gen2](./iks-vpc-gen2)
- Classic: [iks-classic](./iks-classic)
