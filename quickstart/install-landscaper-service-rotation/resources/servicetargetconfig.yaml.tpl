apiVersion: landscaper-service.gardener.cloud/v1alpha1
kind: ServiceTargetConfig

metadata:
  name: ${name}
  namespace: ${namespace}
  labels:
    config.landscaper-service.gardener.cloud/visible: "true"
    config.landscaper-service.gardener.cloud/region: "eu"

spec:
  ingressDomain: ${ingress_domain}
  priority: 10
  secretRef:
    key: ${key}
    name: ${name}
    namespace: ${namespace}
