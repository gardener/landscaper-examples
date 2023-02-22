apiVersion: landscaper.gardener.cloud/v1alpha1
kind: Installation
metadata:
  name: ${name}
  namespace: ${namespace}
  annotations:
    landscaper.gardener.cloud/operation: reconcile

spec:

  context: ${context_name}

  componentDescriptor:
    ref:
      componentName: github.com/gardener/landscaper-service/ingress-controller
      version: v0.39.0-dev-29feb6279221ae088be86bcfbd74ed4b817b027a

  blueprint:
    ref:
      resourceName: ingress-controller-blueprint

  imports:
    targets:
      - name: targetCluster
        target: ${target_name}

  importDataMappings:
    namespace: kube-system
