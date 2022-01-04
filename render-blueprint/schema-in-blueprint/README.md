# Schema in Blueprint

This example contains a blueprint and example values to test the command `landscaper-cli blueprint render ...`.

The import parameters of the blueprint are typed using schemas that are located in the blueprint directory. 
The schemas are referenced using the 
[blueprint protocol](https://github.com/gardener/landscaper/blob/master/docs/usage/JSONSchema.md), for example:
```yaml
imports:
- name: gardenletConfigurations
  schema:
    type: array
    items:
      $ref: "blueprint://schemas/gardenlet-configuration.json"
```

Execute script `test/render.sh` to test the render command. 

The render command validates the example values provided in `test/values.yaml` and executes the templating of the 
deploy items. There are no subinstallations. The results are written to directory `test/result`.
