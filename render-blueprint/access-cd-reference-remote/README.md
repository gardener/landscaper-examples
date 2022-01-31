# Accessing component reference of a component

**Note**: There is an open issue which is relevant in this example: 
[render of blueprint fails when referenced component is not available locally #121](https://github.com/gardener/landscapercli/issues/121)

This example contains a blueprint that accesses a referenced component of its component descriptor.

Execute script `test/render.sh` to test the render command. 

The render command validates the example values provided in `test/values.yaml` and executes the templating of the 
deploy items. There are no subinstallations. The results are written to directory `test/result`.
