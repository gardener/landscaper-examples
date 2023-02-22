# Rotation

1. Copy file `settings-template` to a file with name `settings` in the same directory.
2. Maintain the parameters in the `settings` file.  

## Rotation of Project Credentials

Precoditions: 
- a users with the SAM role for the laas project (`laas-project-kubeconfig-sam`) 
  and resource cluster project (`resourcecluster-project-kubeconfig-sam`),  
- in both projects a ServiceAccount with admin role.

Script 11 creates kubeconfigs for the admin ServiceAccounts of the projects and writes them to the secret store
(`laas-project-kubeconfig-admin` and `resourcecluster-project-kubeconfig-admin`). 
The kubeconfig have a limited validity.


## Deployment of the Core Landscaper

Script 21 uses the admin kubeconfig for the laas project to create 
a short living admin kubeconfig for the core cluster (`core-kubeconfig-admin`) and
a short living admin kubeconfig for the target cluster (`target-kubeconfig-admin`).
They are used to deploy stuff to these cluster, not to run it.

Script 22 uses the `core-kubeconfig-admin` to deploy the core landscaper by helm.


## Deployment of the LaaS

Scripts 31 - 34 install the LaaS on the core cluster.


## ServiceTargetConfig

Script 41 creates a ServiceAccount on the target cluster.

Script 42 creates a ServiceTargetConfig on the core cluster. 
It references a kubeconfig for the ServiceAccount created in script 41.


## Ingress Controller

Scripts 51 - 52 deploy an ingress controller on the target cluster. 
It will be needed for the webhooks of the landscaper instances running on the target cluster.
