# Create Target

Script `create-target.sh` creates a `Target` containing the kubeconfig whose path is given in the
variable `TARGET_KUBECONFIG_PATH`. Before running the script, adjust the values of

- `TARGET_KUBECONFIG_PATH`
- `TARGET_NAME`
- `TARGET_NAMESPACE`

The resulting manifest is written to file `target.yaml` from where you can apply it to a cluster.
