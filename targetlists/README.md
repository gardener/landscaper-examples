# TargetLists

This directory contains some examples on how TargetList imports can be used to render one DeployItem or one subinstallation per Target in a TargetList.

All of the provided examples work with a Target `target-cluster` of type `landscaper.gardener.cloud/kubernetes-cluster`, which is added to a TargetList import three times. The Installations then create an empty secret `foo-<index>` for each Target in the `default` namespace of the targeted cluster.
Unless the Installation is modified to use different Targets as part of its TargetList import, this means there will three secrets `foo-0`, `foo-1`, and `foo-2` be created in the targeted cluster. Note that having multiple of the example Installations active at the same time will clash, since they all create the same secrets.

There are two examples each for rendering one DeployItem per Target and for rendering one subinstallation per Target - one using `GoTemplate` and one with `Spiff`.

All of the examples use an inline blueprint (and also dummy inline component descriptors). This is not recommended for productive purposes, but it should be easy to create equivalent installations which pull their blueprint from a registry.
Note that the two examples which create one subinstallation per Target also use an inline blueprint for the nested installation, which allows to render the index into the created secret's name - this only works because the nested blueprint is rendered together with the outer `subinstallationExecution` and would require an import, if the nested blueprint was not provided inline.
