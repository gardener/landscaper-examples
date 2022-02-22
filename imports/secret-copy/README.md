# Copy a Secret

:warning: This example is not correct!

In this example, an installation imports values from a secret.
The complete data section of the secret is bound to one input parameter.

The blueprint uses the manifest deployer to create a copy of the secret 
on the target cluster.

#### Problem

The deploy item for the current example looks as follows and cannot be applied:

```yaml
spec:
  config:
    apiVersion: manifest.deployer.landscaper.gardener.cloud/v1alpha2
    kind: ProviderConfiguration
    manifests:
    - manifest:
        apiVersion: v1
        kind: Secret
        metadata:
          name: secret-copy-result
          namespace: example
        stringData:
          exampleBoolean: true
          exampleList:
          - 4
          - 5
          - 6
          exampleNumber: 100
          exampleObj:
            a: 1
            b: 2
          exampleString: blue
      policy: manage
    updateStrategy: update
  context: default
  target:
    name: my-cluster
    namespace: example
  type: landscaper.gardener.cloud/kubernetes-manifest
```
