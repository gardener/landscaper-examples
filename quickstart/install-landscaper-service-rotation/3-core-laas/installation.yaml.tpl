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
      componentName: github.com/gardener/landscaper-service
      version: ${version}

  blueprint:
    ref:
      resourceName: landscaper-service-blueprint

  imports:
    targets:
      - name: targetCluster
        target: laas-target-cluster

  importDataMappings:
    namespace: ${namespace}
    verbosity: debug

    # optional: registry pull secrets, list of secrets in "kubernetes.io/dockerconfigjson" format
    registryPullSecrets:
      - name: ${pullsecret}
        namespace: ${namespace}

    gardenerConfiguration:
      serviceAccountKubeconfig:
        name: resourcecluster-project-kubeconfig
        namespace: ${namespace}
        key: kubeconfig
      projectName: ${project}
      shootSecretBindingName: ${cp_secret}
