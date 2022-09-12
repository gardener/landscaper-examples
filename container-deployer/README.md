# Examples using the Container Deployer

### Example [container-1](./container-1)

This example deploys a Kubernetes configmap using the container deployer and a python base container image.
The user can specify the name, namespace and the content of the deployed configmap in the data imports.
The example exports the following data objects:

* `configmapdata`: Contains the data section of the deployed configmap.
* `component`: Contains the component name and version used by the installation.
* `content`: Contains the list and file properties of blueprint files provided to the container deployer.
