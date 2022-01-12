# Simple Example

This example shows the rendering of a blueprint with the command `landscaper-cli blueprint render ...`.
The command is contained in script [./test/render.sh](./test/render.sh). So you can run this script to try out 
the rendering.

The command uses the blueprint in directory [./blueprint](./blueprint) and example values from 
file [./test/values.yaml](./test/values.yaml). The command does the following:

- It validates the example values using the types of the imports in the blueprint. 
- It renders the deploy item from the template in [./blueprint/deploy-execution.yaml](./blueprint/deploy-execution.yaml) 
and writes the result to directory [./test/result](./test/result)

In this example the blueprint has no subinstallations, so that only deploy items are templated.
