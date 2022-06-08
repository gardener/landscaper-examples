apiVersion: landscaper-service.gardener.cloud/v1alpha1
kind: LandscaperDeployment
metadata:
  name: ${name}
  namespace: ${namespace}
spec:
  tenantId: ${tenant}
  purpose: "test"
  landscaperConfiguration:
    deployers:
      - manifest
      - container
      - helm
