# Schema in Component Descriptor

## Scenario 1: Rendering the Blueprint


## Scenario 2: Installing the Component with Landscaper 

The steps in this section have already been done. The component descriptor is available 
[here](https://eu.gcr.io/gardener-project/landscaper/examples/component-descriptors/github.com/gardener/landscaper-examples/render-blueprint/schema-in-cd).

- Script [add-resources.sh](./test/add-resources.sh) adds the resources from the [resources file](./resources.yaml) to
the [component descriptor](./component-descriptor.yaml).

- Script [push-component.sh](./test/push-component.sh) pushes the component descriptor to the OCI registry that is
specified in the base url of the component descriptor.

