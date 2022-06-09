apiVersion: landscaper.gardener.cloud/v1alpha1
kind: Context
metadata:
  name: landscaper-service
  namespace: ${namespace}

repositoryContext:
  baseUrl: eu.gcr.io/sap-se-gcr-k8s-private/cnudie/gardener/development
  type: ociRegistry

registryPullSecrets:
  - name: landscaper-service-pullsecret
