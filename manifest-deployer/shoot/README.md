# Example How To Create a Shoot With Landscaper

This example demonstrates how to create a Gardener Shoot cluster with Landscaper.

There are two variants of this example. The difference between them is where the `blueprint` is stored, which defines
the general deploy procedure.
- In the present example, the `blueprint` is stored in an OCI registry, and Landscaper reads it from there.
- In the  [other variant](../shoot-inline), the `blueprint` is contained inline in the 
[Installation](./installation/installation.yaml).


## Resources

The following `DataObject` custom resources contain the configuration for the shoot cluster:

- [installation/do-shoot-name.yaml](./installation/do-shoot-name.yaml)  
- [installation/do-shoot-namespace.yaml](./installation/do-shoot-namespace.yaml)  
- [installation/do-shoot-secret-binding-name.yaml](./installation/do-shoot-secret-binding-name.yaml)  
- [installation/do-shoot-config.yaml](./installation/do-shoot-config.yaml)  

The following `Target` custom resources should contain the kubeconfig to your Gardener project, where the `Shoot`
resource should be created.

- [installation/target.yaml](./installation/target.yaml)

Finally, there is the following `Installation` custom resource:

- [installation/installation.yaml](./installation/installation.yaml)

The `Installation` combines two things: its `blueprint` section contains the general deploy logic; and its `imports`
section references all the `DataObjects` and the `Target` above with the specific configuration.

## Procedure

Adjust the resources above, and apply them to your Landscaper resource cluster.
