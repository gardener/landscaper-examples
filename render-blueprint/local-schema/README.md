# Local Schema

This example contains a blueprint and example values to test the command `landscaper-cli blueprint render ...`.

The import parameters of the blueprint are typed using a schema that defined locally in the `blueprint.yaml` file.
The schema is referenced using the
["local" protocol](https://github.com/gardener/landscaper/blob/master/docs/usage/JSONSchema.md):
```yaml
imports:
  - name: vpa
    required: false
    schema:
      $ref: "local://vpa"
```

Execute script `test/render.sh` to test the render command. 

The render command validates the example values provided in `test/values.yaml` and executes the templating of the 
deploy items. There are no subinstallations. The results are written to directory `test/result`.
