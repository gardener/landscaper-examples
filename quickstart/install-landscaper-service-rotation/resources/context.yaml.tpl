apiVersion: landscaper.gardener.cloud/v1alpha1
kind: Context
metadata:
  name: ${name}
  namespace: ${namespace}

repositoryContext:
  baseUrl: ${base_url}
  type: ociRegistry

registryPullSecrets:
  - name: ${pullsecret}
