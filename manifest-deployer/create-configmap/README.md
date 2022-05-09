# Create ConfigMap

This example tests the creation of a configmap with the manifest deployer.

The component used in this example exists in different versions. The difference between the versions is the number of
import parameters of the blueprint.

- Version `v0.1.0`: the blueprint has 1 import parameter to make the name of the configmap configurable.

- Version `v0.1.1`: the blueprint has 2 import parameter to make the name of the configmap configurable, as well the
  value in the data section inside the configmap

- Version `v0.1.2`: the blueprint has 3 import parameter to make the name of the configmap configurable, as well the
  key and value in the data section inside the configmap.

For each version there are alternatives how the values for the imports are provided. 
For example: 

- the installation in [v0.1.0/installation-a](./v0.1.0/installation-a) specifies the value for the single import 
  parameter in an importDataMapping,

- the installation in [v0.1.1/installation-a](./v0.1.1/installation-a) reads both imports from one configmap,

- the installation in [v0.1.1/installation-b](./v0.1.1/installation-b) reads both imports from 2 separate configmaps.

- the installation in [v0.1.2/installation-a](./v0.1.2/installation-a) reads all 3 imports from one configmap,

- the installation in [v0.1.2/installation-b](./v0.1.2/installation-b) reads all 3 imports from 3 separate configmaps.

- the installation in [v0.1.2/installation-b](./v0.1.2/installation-d) reads all 3 imports from 3 separate data objects.

Remark: Do not confuse the involved configmaps. On the one hand, there are configmaps containing the import values. 
On the other hand, when you execute one of the examples, the result will be a configmap. 
