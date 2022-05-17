# Examples using the Helm Deployer

### Example [helm-1](./helm-1)

This example deploys an nginx helm chart. Chart and image are declared as resources in the component
descriptor. 

### Example [helm-2](./helm-2): Protected Chart Repository

This example deploys an echo server. The helm chart comes from a protected helm chart repository.
The access data are provided in a `Context` custom resource. The installation references this context resource.

### Example [helm-3](./helm-3): Digest

This is the same as the previous example helm-2, except that the component descriptor references the container image 
via digest, rather than tag.
