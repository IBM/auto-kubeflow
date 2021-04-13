# **One-Click Deploy Kubeflow to IBM Cloud for Multi Users**

## Goals

## In this tutorial, you will learn how to quickly deploy a Kubeflow cluster in IBM Cloud for multiple users, then run a sample pipeline to understand how various Kubeflow components work together to support machine learning operations.

## The tools

1. Schematics: IBM Cloud&#39;s deployment manager, [https://cloud.ibm.com/schematics/overview](https://cloud.ibm.com/schematics/overview)
2. Ansible: IT automation engine
3. Automation project: automation scripts leveraging Schematics and Ansible, https://github.com/yhwang/auto-kubeflow

## Prerequisites

You need to prepare the following in IBM Cloud
- IBM cloud account (with ability to create an IBM Kubernetes Cluster, either classic or VPC Gen2)
- IBM cloud API key
- Organization in IBM Cloud
- Space in IBM Cloud

## What does the automation do?

In the case of deploying to a classic cluster, it will
- Create a classic cluster
- Create an IBM AppID service instance
- Deploy Kubeflow for multi-user into the classic cluster
- Configure Kubeflow for multi-user with AppID service

In the case of deploying to a VPC Gen2 cluster, it will
- Create a VPC
- Create a VPC Gen2 cluster
- Create a VPC subnet
- Create a VPC public gateway for the VPC cluster and subnet
- Create an IBM AppID service instance
- Deploy Kubeflow for multi-user into the VPC Gen2 cluster
- Configure Kubeflow for multi-user with AppID service


## Steps

1. Setup prerequisites
  - Get an IBM Cloud account from [https://www.ibm.com/cloud](https://www.ibm.com/cloud) with ability to create Classic or VPC Gen2 clusters
  - Login to your account and create an IBM Cloud API key from menu Manage-Access (IAM)-API keys
  - Create an organization from menu Manage-Account-Cloud Foundry orgs
  - Add a space to your newly created organization
2. Create and configure Schematics workspace
  - Login to your account and create a Schematics workspace from menu Schematics-Workspaces, providing a name and taking defaults for the rest
  - To deploy Kubeflow onto a classic cluster, configure your workspace in Settings page
    1. Github resource URL: [https://github.com/yhwang/auto-kubeflow/tree/main/terraform/classic](https://github.com/yhwang/auto-kubeflow/tree/main/terraform/classic)
    2. Terraform version: terraform\_v0.14
    3. Update variable values
      - ibmcloud_api_key: the IBM Cloud API key created in step 1
      - org: the orgnization created in step 1
      - space: the space created in step 1
      - appid_plan: graduated-tier (optional)
      - zone: the zone where the cluster will be created. You can use ibmcloud ks zone ls --provider classic to get the available zones.
      - public_vlan_id: The public vlan id. You can use ibmcloud ks vlan ls --zone <zone> to list the available public vlans
      - private_vlan_id: The private vlan id. You can use ibmcloud ks vlan ls --zone <zone> to list the available private vlans
  - To deploy Kubeflow onto a VPC Gen2 cluster, configure your workspace in Settings page
    1. Github resource URL: [https://github.com/yhwang/auto-kubeflow/tree/main/terraform/iks-vpc-gen2](https://github.com/yhwang/auto-kubeflow/tree/main/terraform/iks-vpc-gen2)
    2. Terraform version: terraform\_v0.14
    3. Update variable values
      - ibmcloud_api_key: the IBM Cloud API key created in step 1
      - org: the orgnization created in step 1
      - space: the space created in step 1
      - appid_plan: graduated-tier (optional)
      - cluster_name (optional): change the prefix for your cluster name, as the final cluster name is going to be <cluster_name>-xxxx, where xxxx is randomly generated four charaters
3. Generate and execute deployment plan
  - Click Generate plan and observe the generated plan in Activity-View log
  - Click Apply plan and observe the deployment progress in Activity-View log
    1. Note this step will take about 35 (classic) or 75 (VPC Gen2) minutes to deploy and configure the complete Kubeflow cluster.
    2. You should see eight outputs and "Command finished successfully." at the bottom of the log.
4. Verify deployment
  - Check the deployed resources in Resources
  - Access Kubeflow UI, https://<cluster\_hostname>. You can find the <cluster\_hostname> as one of the outputs in the Apply plan log.
  - Login as user A, using an existing Google or Facebook account
    1. Click Login with Google or Login with Facebook
    2. Click Start Setup on Kubeflow Welcome page
    3. Take the default namespace and click Finish on Kubeflow Namespace page
  - Login as user B, using a new account with a different email
    1. Click Sign up!
    2. Enter email and password for the new account
    3. Open the notification email and click Verify
    4. Login with the email and password
    5. Click Start Setup on Kubeflow Welcome page
    6. Take the default namespace, should be different from user A, and click Finish on Kubeflow Namespace page
  - Run the demo pipeline
    1. Create an experiment
    2. Click [Demo] flip-coin and Create run
    3. Choose the experiment and Start
    4. Observe the run graph
    5. Click each graph node to see more details
5. Clean up resources (optional)
  - After you are done with the Kubeflow experiment, you can clean up the cluster and other resources from Action...-Delete and choose the "Delete all associated resources" option. As long as the workspace is not deleted, you can always go back to step 3 to deploy a brand new cluster.

## Estimated time

- Step 1: 5 minutes
- Step 2: 5 minutes
- Step 3: 40/80 minutes (5 min configuration + 35/75 min automation)
- Step 4: 10 minutes
- Step 5: 15 minutes

## Summary

With this automation, it is easy to deploy a stack of Kubeflow components into an IBM Kubernetes Cluster, Classic or VPC Gen2, for multiple users. You will be able to see the demo pipeline running quickly. Additionally you could check out other Kubeflow features such as Notebook Servers and Katib (hyperparameter tuning) to become more familiar with this cloud-native platform for machine learning operations.
