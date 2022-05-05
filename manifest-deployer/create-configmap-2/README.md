# Create ConfigMap with 3 Imports

This example tests the creation of a configmap with the manifest deployer.

This is example uses the same component as [create-configmap](../create-configmap) and
[create-configmap-1](../create-configmap-1), but here in component version `v0.1.2`,
where the blueprint has 3 import parameters: the name of the configmap, as well as a key and a value for the data 
section inside the configmap.

There are two variants how to provide the import values:

- installation A reads all 3 imports from one configmap,
- installation B reads each import from a separate configmap.
