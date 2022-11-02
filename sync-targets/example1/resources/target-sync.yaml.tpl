apiVersion: landscaper.gardener.cloud/v1alpha1
kind: TargetSync
metadata:
  name: ${name}
  namespace: ${namespace}
spec:
  secretNameExpression: "\\.kubeconfig$"
  secretRef:
    name: ${name}
    key: kubeconfig
  sourceNamespace: ${sourceNamespace}
  tokenRotation:
    serviceAccountName: ${serviceAccountName}

