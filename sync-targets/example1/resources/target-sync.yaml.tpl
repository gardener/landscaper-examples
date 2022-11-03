apiVersion: landscaper.gardener.cloud/v1alpha1
kind: TargetSync
metadata:
  name: ${name}
  namespace: ${namespace}
  #annotations:
    #landscaper.gardener.cloud/rotate-token: ok
spec:
  secretNameExpression: "\\.kubeconfig$"
  secretRef:
    name: ${name}
    key: kubeconfig
  sourceNamespace: ${sourceNamespace}
  tokenRotation:
    enabled: true

