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
      - "apiextensions.k8s.io"
    resources:
      - "customresourcedefinitions"
    verbs:
      - "*"
  - apiGroups:
      - "landscaper.gardener.cloud"
    resources:
      - "*"
    verbs:
      - "*"
  - apiGroups:
      - "landscaper-service.gardener.cloud"
    resources:
      - "*"
    verbs:
      - "*"
  - apiGroups:
      - "admissionregistration.k8s.io"
    resources:
      - "validatingwebhookconfigurations"
    verbs:
      - "*"
  - apiGroups:
      - ""
    resources:
      - "events"
    verbs:
      - create
      - get
      - watch
      - patch
      - update
  - apiGroups:
      - ""
    resources:
      - "secrets"
      - "configmaps"
    verbs:
      - "*"
  - apiGroups:
      - ""
    resources:
      - "serviceaccounts"
      - "services"
    verbs:
      - get
      - list
      - watch
      - create
      - update
      - delete
  - apiGroups:
      - "apps"
    resources:
      - "deployments"
    verbs:
      - get
      - list
      - watch
      - create
      - update
      - delete
      - patch
  - apiGroups:
      - ""
    resources:
      - "namespaces"
    verbs:
      - get
      - list
      - watch
  - apiGroups:
      - "rbac.authorization.k8s.io"
    resources:
      - "clusterroles"
      - "clusterrolebindings"
    verbs:
      - get
      - list
      - watch
      - create
      - update
      - delete
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
