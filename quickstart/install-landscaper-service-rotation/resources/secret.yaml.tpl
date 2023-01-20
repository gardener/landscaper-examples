apiVersion: v1
kind: Secret
metadata:
  name: ${name}
  namespace: ${namespace}
data:
  ${key}: ${value}
type: Opaque
