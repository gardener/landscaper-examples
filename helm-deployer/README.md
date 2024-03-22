# Examples using the Helm Deployer


### Example [helm-1](./helm-1): Helm Repository

This example deploys an nginx helm chart.
The Helm chart is stored in a Helm chart repository (as opposed to an OCI registry).
The Blueprint is stored as local resource of the component version.
Blueprint, chart, and image are declared as resources in the component constructor.

The component version was uploaded with the [commands/component.sh](helm-1/commands/component.sh).

Downloaded component descriptor: [component/component-descriptor.yaml](helm-1/component/component-descriptor.yaml).

The Installation requires a Target and Context, which can be created by adjusting the [hack/settings](../hack/settings)
and running the script [hack/deploy-context-and-target.sh](../hack/deploy-context-and-target.sh).


### Example [helm-2](./helm-2): Protected Helm Repository

This example demonstrates how to store the credentials for a protected helm repository in a Context custom resource.

The example cannot be tried out, because the chart does no longer exist.


### Example [helm-3](./helm-3): Digest

This is the same as the previous example helm-2, except that the component descriptor references the container image 
via digest, rather than tag.

The example cannot be tried out, because the chart does no longer exist.


### Example [helm-4](./helm-4): Helm Chart in an OCI Registry

This example deploys a Helm chart that simply creates a `ConfigMap`. 
The chart is stored in an OCI registry (as opposed to a Helm chart repository).
The Blueprint has an export parameter.


### Example [helm-repo-protected](./helm-repo-protected)

This example demonstrates how the access data for a protected Helm chart repository can be provided in a `Context`
custom resource. There are two variants: 
- the credentials can be stored directly in the `Context` object,
- or they can be stored in a `Secret`, and the `Context` just references the `Secret`.


### Example [helm-tp](./helm-tp)

This example deploys an echo server chart from a public Helm chart repository.
This example demonstrates how to set the Helm values in the deploy execution of the Blueprint.
A part of the Helm values comes from an import parameter of the Blueprint.
The rest of the Helm values specifies the container image; they are read from the component descriptor.


### Example [real-helm-deployment-cd](./real-helm-deployment-cd)

This example deploys an nginx helm chart, stored in a Helm chart repository.
Blueprint and chart are declared as resources in the component descriptor.
The Blueprint also shows how to specify Helm parameters `atomic` and `timeout`.
The Blueprint exports the `.status.loadBalancer` field from the deployed Service.
