# Examples using the Helm Deployer

### Example [helm-1](./helm-1)

This example deploys an nginx helm chart.
The Helm chart is stored in a Helm chart repository (as opposed to an OCI registry).
Blueprint, chart, and image are declared as resources in the component descriptor.

### Example [helm-2](./helm-2): Protected Chart Repository

This example deploys an echo server. 
The Helm chart comes from a protected helm chart repository. The access data are provided in a `Context` custom resource. 
The Installation references this `Context` resource.
Blueprint, chart, and image are declared as resources in the component descriptor.

### Example [helm-3](./helm-3): Digest

This is the same as the previous example helm-2, except that the component descriptor references the container image 
via digest, rather than tag.

### Example [helm-4](./helm-4): Helm Chart in an OCI Registry

This example deploys a Helm chart that simply creates a `ConfigMap`. 
The chart is stored in an OCI registry (as opposed to a Helm chart repository).
The Blueprint has an export parameter.

### Example [real-helm-deployment-cd](./real-helm-deployment-cd)

This example deploys an nginx helm chart, stored in a Helm chart repository.
Blueprint and chart are declared as resources in the component descriptor.
The Blueprint also shows how to specify Helm parameters `atomic` and `timeout`.
The Blueprint exports the `.status.loadBalancer` field from the deployed Service.
