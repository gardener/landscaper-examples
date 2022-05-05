# Create ConfigMap with 2 Imports

This example tests the creation of a configmap with the manifest deployer.

This is example uses the same component as [create-configmap](../create-configmap) and 
[create-configmap-2](../create-configmap-2), but here in component version `v0.1.1`, 
where the blueprint has 2 import parameters: the name of the configmap, as well as a value for the data section
inside the configmap.

There are two variants how to provide the import values:

- installation A reads both imports from one configmap,
- installation B reads each import from a separate configmap.
