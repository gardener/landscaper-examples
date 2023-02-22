# Service Account Kubeconfig

This example demonstrates how to obtain a kubeconfig for a ServiceAccount.
The kubeconfig is obtained during the templating of an export execution of the blueprint.

The present example deploys a ServiceAccount, a RoleBinding, and a Role (to get a namespace).
After the deployment of these resources by the manifest deployer, the export execution uses the templating function 
`getServiceAccountKubeconfig` to obtain a kubeconfig with a token for the new ServiceAccount.
There are two export parameters, one just for the kubeconfig, the other for a Target that contains the kubeconfig.


## Procedure

- Adjust the [target.yaml](installation/target.yaml): set the kubeconfig for your cluster.

- Adjust the [installation.yaml](installation/installation.yaml): in the import data mapping, set the name and 
  namespace of the ServiceAccount to be created.

  ```yaml
  spec:

    importDataMappings:
      serviceAccountName: my-service-account
      serviceAccountNamespace: example
  ```
