# **One-Click Deploy Kubeflow to IBM Cloud for Multi Users**

## Goals

## In this tutorial, you will learn how to quickly deploy a Kubeflow cluster in IBM Cloud for multiple users, then run a sample pipeline to understand how various Kubeflow components work together to support machine learning operations.

## The tools

1. Schematics: IBM Cloud&#39;s deployment manager, [https://cloud.ibm.com/schematics/overview](https://cloud.ibm.com/schematics/overview)
2. Ansible: IT automation engine
3. Automation project: automation scripts leveraging Schematics and Ansible, https://github.com/yhwang/auto-kubeflow

## Prerequisites

- IBM cloud account (with ability to deploy VPC clusters)
- IBM cloud API key
- Organization in IBM Cloud
- Space in IBM Cloud

## What does the automation do?

- Create a VPC
- Create a VPC Gen 2 cluster
- Create a VPC subnet
- Create a VPC public gateway for the VPC cluster and subnet
- Create an IBM AppID service instance
- Deploy Kubeflow for multi-user into the VPC cluster
- Configure Kubeflow for multi-user with AppID service


## Steps

1. Setup prerequisites
  - Get an IBM Cloud account from [https://www.ibm.com/cloud](https://www.ibm.com/cloud) with ability to deploy VPC clusters
  - Login to your account and create an IBM Cloud API key from menu Manage-Access (IAM)-API keys
  - Create an organization from menu Manage-Account-Cloud Foundry orgs
  - Add a space to your newly created organization
2. Create and configure Schematics workspace
  - Login to your account and create a Schematics workspace from menu Schematics-Workspaces, providing a name and taking defaults for the rest
  - Configure your workspace as following
    1. Github resource URL: [https://github.com/yhwang/auto-kubeflow/tree/main/terraform](https://github.com/yhwang/auto-kubeflow/tree/main/terraform)
    2. Terraform version: terraform\_v0.13
    3. Update workspace with variable values
3. Generate and execute deployment plan
  - Click Generate plan and observe the generated plan in Activity-View log
  - Click Apply plan and observe the deployment progress in Activity-View log
4. Verify deployment
  - Access Kubeflow UI, https://\&lt;cluster\_hostname\&gt;. You can find the \&lt;cluster\_hostname\&gt; in the Apply plan outputs.
  - Login as user A (Google account)
  - Login as user B (new account using a different email) and provide a new namespace upon login the first time
  - Run the demo pipeline
    1. Create an experiment
    2. Click [Demo] flip-coin and Create run
    3. Choose the experiment and Start
    4. Observe the run graph
    5. Click each graph node to see more details


## Estimated time

- Step 1: 5 minutes
- Step 2: 5 minutes
- Step 3: 80 minutes (5 min configuration + 75 min automation)
- Step 4: 10 minutes

## Summary

With this automation, it is easy to deploy a stack of Kubeflow components into an IBM VPC cluster for multiple users. You will be able to see the demo pipeline running quickly. Additionally you could check out other Kubeflow features such as Notebook Servers and Katib (hyperparameter tuning) to become more familiar with this cloud-native platform for machine learning operations.
