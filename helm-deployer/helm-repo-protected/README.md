# Loading a chart from a protected helm chart repo

Prerequisites: 
- Namespace `example` contains a target with name `my-cluster`. As an alternative you can adjust the target name in the 
  installation.
- Namespace `example` contains a context with name `helm-repo-protected` which contains the authentication data for
  the protected helm chart repository. See [context.yaml](context.yaml).

The installation deploys an echo server.
The deployment is **not** done with helm.
The helm chart is read from a **protected helm chart repository**.
