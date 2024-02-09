apiVersion: v1
kind: Secret
metadata:
  name: my-pullsecret
  namespace: cu-example
data:
  .dockerconfigjson: ${dockerconfigjson_base64}
type: kubernetes.io/dockerconfigjson