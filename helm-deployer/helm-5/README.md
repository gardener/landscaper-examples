# DeployItem referencing a Helm Chart via Resource in the Component Desciptor

This example deploys the same helm chart `simple-chart` as example `helm-4`.

Normally, the DeployItem references the helm chart via
- oci image reference  
- or helm chart repository url, helm chart name, and helm chart version.  

In the present example, the DeployItem references the helm chart resource in the component descriptor:

```yaml
deployItems:
- config:
    chart:
      fromResource:
        ref:
          repositoryContext:
            baseUrl: eu.gcr.io/gardener-project/landscaper/examples
            type: ociRegistry
          componentName: github.com/gardener/landscaper-examples/helm-deployer/helm-chart-1
          version: v0.1.0
        resourceName: simple-chart
```
