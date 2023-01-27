---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: ${name}
  namespace: ${namespace}
...
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: ${name}
rules:
  - apiGroups:
      - "*"
    resources:
      - "*"
    verbs:
      - "*"
...
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: ${name}
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: ${name}
subjects:
  - kind: ServiceAccount
    name: ${name}
    namespace: ${namespace}
...
