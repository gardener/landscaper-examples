apiVersion: landscaper-service.gardener.cloud/v1alpha1
kind: ServiceTargetConfig

metadata:
  name: ${name}
  namespace: ${namespace}
  labels:
    config.landscaper-service.gardener.cloud/visible: "true"
    config.landscaper-service.gardener.cloud/region: "eu"

spec:
  providerType: gcp
  priority: 10

  secretRef:
    name: ${name}-service-target
    namespace: ${namespace}
    key: kubeconfig
