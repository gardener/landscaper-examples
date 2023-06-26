# Installation Template

The [root blueprint](./blueprints/root/blueprint.yaml) in this example uses an [installation template](./blueprints/root/charts-subinst.yaml) to create a subinstallation for each
resources of type `helm` in the components resource.

The `targetCluster` target import, the `chartValues` and `namespace` data imports are passed unmodified to each created subinstallation.
The installation template creates the `chartName` and `chartRef` data imports for the [charts blueprint](./blueprints/charts/blueprint.yaml).

The `charts blueprint` then creates a deployitem of type `landscaper.gardener.cloud/helm` for the helm chart specified by the `chartName` and `chartRef` import parameters.
