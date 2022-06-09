apiVersion: landscaper.gardener.cloud/v1alpha1
kind: Installation
metadata:
  name: landscaper-service
  namespace: ${namespace}
spec:

  context: landscaper-service

  componentDescriptor:
    ref:
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
    registryPullSecrets:
      - name: landscaper-service-pullsecret
        namespace: ${namespace}
