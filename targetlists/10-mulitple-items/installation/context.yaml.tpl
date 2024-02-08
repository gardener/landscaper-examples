apiVersion: landscaper.gardener.cloud/v1alpha1
kind: Context
metadata:
  name: landscaper-test
  namespace: cu-example

repositoryContext:
  baseUrl: ${repository_base_url}
  type: ociRegistry

registryPullSecrets:
  - name: my-pullsecret
