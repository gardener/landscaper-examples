# Loading a chart from a protected helm chart repo

This example demonstrates the deployment of a helm chart that is pulled from a protected helm chart repository
and then deployed by helm on a target cluster.

Scenario [installation-1](installation-1) uses the following resources on the Landscaper cluster, all in the same 
namespace `example`:

- A target `my-cluster` containing the kubeconfig of the target cluster where the echo-server is being deployed.

- A [context `helm-repo-protected`](context.yaml) which contains the authentication data for
  the protected helm chart repository.

- An [installation `helm-repo-protected`](installation.yaml), which references the target, the context, and the 
  blueprint of component `github.com/gardener/landscaper-examples/helm-deployer/helm-repo-protected`.
  The [deploy item](blueprint/deploy-execution.yaml) of the blueprint in turn references resource `echo-server-chart`
  of the [component descriptor](component-descriptor.yaml), which contains the access data of the helm chart.

Scenario [installation-2](installation-2) is a variation of the first. 
The [context `helm-repo-protected`](installation-2/context.yaml) does not contain the authentication data for the
protected helm chart repository. Rather it references a [secret `helm-repo-auth`](installation-2/secret.yaml) 
which contains the authentication data.
