# Examples using the Helm Deployer

### Example [helm-1](./helm-1)

This example deploys an nginx helm chart. Chart and image are declared as resources in the component
descriptor. The Helm chart is stored in a Helm chart repository (as opposed to an OCI registry).

### Example [helm-2](./helm-2): Protected Chart Repository

This example deploys an echo server. The helm chart comes from a protected helm chart repository.
The access data are provided in a `Context` custom resource. The installation references this context resource.

### Example [helm-3](./helm-3): Digest

This is the same as the previous example helm-2, except that the component descriptor references the container image 
via digest, rather than tag.

### Example [helm-4](./helm-4): Helm Chart in an OCI Registry

This example deploys a Helm chart that is stored in an OCI registry (as opposed to a Helm chart repository).
The Helm chart simply creates a ConfigMap. Moreover, the Blueprint has an export parameter.
