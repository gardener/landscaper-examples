apiVersion: landscaper-service.gardener.cloud/v1alpha1
kind: LandscaperDeployment
metadata:
  name: ${name}
  namespace: ${namespace}
spec:
  landscaperConfiguration:
    deployers:
      - helm
      - manifest
  purpose: test
  tenantId: ${tenant_id}
  oidcConfig:
    clientID: test-client-id
    groupsClaim: groups
    issuerURL: https://my-issuer.test.url.com
    usernameClaim: email
