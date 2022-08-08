# Subinstallations

The blueprint in this example has two subinstallations.
Each subinstallation uses the blueprint of example
[manifest-deployer/export-import](../../manifest-deployer/export-import)
that creates a configmap.

Each subinstallations imports the name of the configmap that it creates (import parameter `configmap-name-in`)
and exports a slightly modified name (export parameter `configmap-name-out`) which serves as import for the following
subinstallation.