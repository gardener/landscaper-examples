apiVersion: landscaper-service.gardener.cloud/v1alpha1
kind: SubjectList
metadata:
  name: subjects
  namespace: ls-user
spec:
  subjects:
    - kind: ServiceAccount
      name: ${customer_serviceaccount}
      namespace: ls-user
