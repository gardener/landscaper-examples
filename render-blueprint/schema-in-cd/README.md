# Schema in Component Descriptor

## Rendering the Blueprint

Script [./test/render-blueprint.sh](./test/render-blueprint.sh) renders a blueprint with some
example values. The render command first validates the example values against a 
[schema](./resources/schemas/vpa.json) before it templates the deploy item of the blueprint.
In the present scenario, the schema is specified as a resource in the component descriptor/[resources.yaml](./resources.yaml) 
and addressed as `cd://resources/vpa` in the blueprint.

## Pushing the Component to the OCI Registry 

The steps in this section have already been done. So you can skip this section.
The resulting component descriptor in the OCI registry is available 
[here](https://eu.gcr.io/gardener-project/landscaper/examples/component-descriptors/github.com/gardener/landscaper-examples/render-blueprint/schema-in-cd).

- Script [./ctf/create-ctf.sh](./ctf/create-ctf.sh) creates a transport file `./ctf/transport.tar`
  and adds a component archive for the current component. The file structure is shown below. 
  The component descriptor in the component archive is enriched with resource entries coming from the 
  [resources.yaml](./resources.yaml) file, whereas the [original component descriptor](./component-descriptor.yaml) 
  remained unchanged. (When you extract the tar files, you might need to `chmod` the blobs directory to see the content.)

    ```
    transport.tar
    └── github.com_gardener_landscaper-examples_render-blueprint_schema-in-cd-v0.1.0.tar
        ├── component-descriptor.yaml
        └── blobs
            ├── sha256:26067ee4154fc83488e8df31b36dc6e22a8099cce1649a489c8305c7eef8bff6
            └── sha256:a424aa0dda2de75ee800e888185c2e113e3a9a3fc8906ab99c4a0ae99c085a36
    ```

- Script [./ctf/push-ctf.sh](./ctf/push-ctf.sh) pushes the component to the OCI registry that is
  specified in the base url of the component descriptor.

## Deploying with Landscaper


