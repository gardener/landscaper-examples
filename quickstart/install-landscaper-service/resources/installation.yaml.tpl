apiVersion: landscaper.gardener.cloud/v1alpha1
kind: Installation
metadata:
  name: landscaper-service
  namespace: ${namespace}
spec:
  componentDescriptor:
    ref:
      repositoryContext:
        type: ociRegistry
        baseUrl: eu.gcr.io/gardener-project/development
      componentName: github.com/gardener/landscaper-service
      version: ${version}

  blueprint:
    ref:
      resourceName: landscaper-service-blueprint

  imports:
    targets:
      - name: targetCluster
        target: "#laas-target-cluster"

  importDataMappings:
    namespace: ${namespace}
    verbosity: 2

    # optional: registry pull secrets, list of secrets in "kubernetes.io/dockerconfigjson" format
    # registryPullSecrets:
    #  - name: secret1
    #    namespace: laas-system
    #  - name: secret2
    #    namespace: laas-system
