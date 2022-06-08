apiVersion: v1
kind: Secret
metadata:
  name: ${name}-service-target
  namespace: ${namespace}
type: Opaque
stringData:
  # set your kubeconfig
  kubeconfig: |
    apiVersion: v1
    kind: Config
    current-context: ...
    ...
