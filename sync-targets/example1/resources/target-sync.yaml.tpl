apiVersion: landscaper-service.gardener.cloud/v1alpha1
kind: TargetSync
metadata:
  name: ${name}
  namespace: ${namespace}
spec:
  secretNameExpression: "\\.kubeconfig$"
  secretRef:
    name: ${name}
    namespace: ${namespace}
    key: kubeconfig
  sourceNamespace: ${sourceNamespace}

