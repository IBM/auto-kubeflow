# auto-kubeflow
[Kubeflow](https://www.kubeflow.org/), an end-to-end Machine Learning(ML)
platform on kubernetes, provides components and features to compose ML
pipelines. On [Kubeflow website](https://www.kubeflow.org/docs/), it provides
lots of documentation, including Geting Started, tutorials, deployment and etc,
help you understand its components and features. However, when come to
deployment on specific cloud provider, it usually involves kubernetes cluster
creation, environment setup locally, deployment, configuration and etc. One
mistake in these procedures may lead to a painful debugging, reconfiguration
and even do-over from scratch.

In this repo, we focus on providing a convenient approach to deployment
Kubeflow on [IBM Cloud](https://cloud.ibm.com/):
- Use Schematics/Terraform + Ansible to create a kubernete cluster on IBM Cloud,
  deploy multi-user kubeflow and integrate with AppID service as login
  mechanism.

It leverages the [Schematics service](https://cloud.ibm.com/schematics/overview)
on IBM Cloud to provision resources and kubernetes cluster service. Then it
finishes the deployment and configuration with Ansible playbook.

Here is the summary of the contnets provided in this repo (more to come):
- [Schematics terraform scripts for deploy kubeflow on IBM Kubernete Service
  using classic cluster](terraform/iks-classic/).
- [Schematics terraform scripts for deploy kubeflow on IBM Kubernete Service
  using VPC Gen 2 cluster](terraform/iks-vpc-gen2/)
- [Step by step tutorial of using Schematics service and resources on this repo
  to deploy a multi-user kubeflow cluster](tutorials/deploy_ibm_cloud.md)

Currently, the deployment is targeting kubeflow v1.7.0. The manifest used to
deploy kubeflow is here:
https://github.com/IBM/manifests/archive/v1.7-branch.tar.gz

If you want to deploy previous release, you can find corresponding branches in
this repository, i.e. v1.4.0 in `kf-v1.4.0` branch and v1.3.1 in `kf-v1.3.1` branch.
When you go the the specific branch, you can see which manifests it uses. For example,
you can use this url as the your workspace in schematics:
https://github.com/IBM/auto-kubeflow/tree/kf-v1.3.1/terraform/iks-classic .
It deploys kubeflow v1.3.1 using https://github.com/IBM/manifests/archive/v1.3.1.tar.gz
manifests.

For you to get start, please check out the tutorial
[here](tutorials/deploy_ibm_cloud.md). It will guid you through the deployment
process. Hopefully, you would be able to have a kubeflow cluster up and running
with just a few clicks.
